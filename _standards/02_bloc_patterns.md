# BLoC Patterns

> ⚠️ **Paginated lists**: the pagination fields below (`pageKey`/`pageSize`/`totalCount`/`maxItems`) belong to the **web back-office** pattern (`DataTable2` with an adjustable page size). **The default for lists in kit apps is infinite scroll (`PagingController`), with no `pageSize`/`totalCount` in state:** follow [13_mobile_pagination.md](13_mobile_pagination.md) for any paginated list. Everything else below (event/state shape, `GenericStatus`, 5-step handler backbone, `GenericFlowStep`, CRUD) applies as-is.
>
> **Freezed 3+:** every Freezed class is declared `sealed class` (events, states and models). The generated `when`/`map` methods no longer exist: use Dart's `switch` on the sealed type instead.

## File Structure (3 files per feature)

```
features/{feature}/bloc/
├── {feature}_bloc.dart          # Main file — `part` directives go here
├── {feature}_event.dart         # `part of '{feature}_bloc.dart'`
├── {feature}_state.dart         # `part of '{feature}_bloc.dart'`
└── {feature}_bloc.freezed.dart  # Generated — do not edit
```

---

## Event Pattern

```dart
// {feature}_event.dart
part of '{feature}_bloc.dart';

@freezed
sealed class MyFeatureEvent with _$MyFeatureEvent {
  // Lifecycle
  const factory MyFeatureEvent.init() = _Init;
  const factory MyFeatureEvent.reset() = _Reset;
  const factory MyFeatureEvent.resetFlowStep() = _ResetFlowStep;

  // Data fetching
  const factory MyFeatureEvent.fetchMyFeatures({
    @Default(0) int pageKey,
    String? searchTerm,
    int? size,
  }) = _FetchMyFeatures;
  const factory MyFeatureEvent.refreshMyFeatures() = _RefreshMyFeatures;
  const factory MyFeatureEvent.selectMyFeature(MyFeature item) = _SelectMyFeature;

  // CRUD
  const factory MyFeatureEvent.createMyFeature(MyFeature item) = _CreateMyFeature;
  const factory MyFeatureEvent.updateMyFeature(MyFeature item) = _UpdateMyFeature;
  const factory MyFeatureEvent.deleteMyFeature(MyFeature item) = _DeleteMyFeature;
}
```

**Rules:**
- All factory constructors use named parameters ONLY
- NEVER pass `Map<String, dynamic>` as an event parameter
- Use `@Default(value)` for optional parameters that have sensible defaults
- Use typed enums for filter parameters (e.g., `StatutAbsence? statut`)
- Private generated classes follow the pattern `_PascalCaseName`

---

## State Pattern

```dart
// {feature}_state.dart
part of '{feature}_bloc.dart';

@freezed
sealed class MyFeatureState with _$MyFeatureState {
  const factory MyFeatureState({
    // --- List data ---
    @Default([]) List<MyFeature> myFeatures,
    @Default([]) List<MyFeature> paginatedMyFeatures,
    MyFeature? selectedMyFeature,

    // --- Pagination ---
    @Default(false) bool maxMyFeatures,
    @Default(false) bool refreshController,
    @Default(0) int pageKey,
    @Default(10) int pageSize,
    @Default(0) int totalCount,

    // --- Status fields (one per operation group) ---
    @Default(GenericStatus.initial) GenericStatus myFeatureStatus,         // list
    @Default(GenericStatus.initial) GenericStatus myFeatureDetailStatus,   // single item
    @Default(GenericStatus.initial) GenericStatus myFeatureActionStatus,   // CRUD actions

    // --- Flow step ---
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,

    // --- Error messages (one per operation group) ---
    String? myFeatureListErrorMessage,
    String? myFeatureDetailErrorMessage,
    String? myFeatureActionErrorMessage,
  }) = _MyFeatureState;
}
```

**Rules:**
- One state class per BLoC — never multiple state subclasses
- Multiple `GenericStatus` fields — one per independent operation
- Always include `GenericFlowStep flowStep` for CRUD features
- Always include `bool refreshController` — flipping it triggers DataSource refresh
- Pagination fields: `pageKey`, `pageSize`, `totalCount`, `maxItems`, `paginatedItems`, `allItems`
- Error messages are `String?`, one per operation group

---

## BLoC Class Pattern

```dart
// {feature}_bloc.dart
part '{feature}_event.dart';
part '{feature}_state.dart';
part '{feature}_bloc.freezed.dart';

class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
  final MyFeatureRepository _repository;

  MyFeatureBloc({required MyFeatureRepository repository})
      : _repository = repository,
        super(const MyFeatureState()) {
    on<_Init>(_onInit);
    on<_FetchMyFeatures>(_onFetchMyFeatures);
    on<_RefreshMyFeatures>(_onRefreshMyFeatures);
    on<_SelectMyFeature>(_onSelectMyFeature);
    on<_CreateMyFeature>(_onCreateMyFeature);
    on<_UpdateMyFeature>(_onUpdateMyFeature);
    on<_DeleteMyFeature>(_onDeleteMyFeature);
    on<_ResetFlowStep>(_onResetFlowStep);
    on<_Reset>(_onReset);
  }
  // ...handlers below
}
```

---

## Handler Pattern (5-step — ALWAYS)

```dart
Future<void> _onFetchMyFeatures(
    _FetchMyFeatures event, Emitter<MyFeatureState> emit) async {

  // STEP 1: Emit loading
  emit(state.copyWith(
    myFeatureStatus: event.searchTerm != null
        ? GenericStatus.filtering
        : GenericStatus.loading,
    myFeatureListErrorMessage: null,
    myFeatures: event.pageKey == 0 ? [] : state.myFeatures,
  ));

  try {
    // STEP 2: Call repository
    final result = await _repository.fetchMyFeatures(
      event.pageKey,
      keyword: event.searchTerm,
      size: event.size ?? state.pageSize,
    );

    if (result != null) {
      // STEP 3: Emit success
      final newItems = result.content as List<MyFeature>;
      emit(state.copyWith(
        myFeatureStatus: GenericStatus.success,
        pageKey: event.pageKey,
        totalCount: result.pagination.totalElement ?? 0,
        maxMyFeatures: newItems.length < (event.size ?? state.pageSize),
        paginatedMyFeatures: newItems,
        myFeatures: event.pageKey == 0
            ? newItems
            : [...state.myFeatures, ...newItems],
      ));
    } else {
      // STEP 4: Emit failure on null
      emit(state.copyWith(
        myFeatureStatus: GenericStatus.failure,
        maxMyFeatures: true,
        paginatedMyFeatures: [],
        myFeatureListErrorMessage:
            LocalizationService.localization.errorLoadingMyFeatures,
      ));
    }
  } on HttpException400 catch (e) {
    // STEP 5a: Specific exception
    emit(state.copyWith(
      myFeatureStatus: GenericStatus.failure,
      myFeatureListErrorMessage:
          e.message ?? LocalizationService.localization.errorLoadingMyFeatures,
    ));
  } catch (e) {
    // STEP 5b: Generic catch-all
    log('Error fetching my features: $e');
    emit(state.copyWith(
      myFeatureStatus: GenericStatus.failure,
      myFeatureListErrorMessage:
          LocalizationService.localization.errorLoadingMyFeatures,
    ));
  }
}
```

**CRUD action handler (create/update/delete):**

```dart
Future<void> _onCreateMyFeature(
    _CreateMyFeature event, Emitter<MyFeatureState> emit) async {

  // STEP 1: Set flowStep + loading
  emit(state.copyWith(
    flowStep: GenericFlowStep.creatingItem,
    myFeatureActionStatus: GenericStatus.loading,
    myFeatureActionErrorMessage: null,
  ));

  try {
    // STEP 2: Build payload in BLoC/Repository — NOT in UI
    final payload = MyFeature.createPayload(event.item);
    final result = await _repository.createMyFeature(payload);

    if (result != null) {
      // STEP 3: Success — set refreshController to trigger DataSource refresh
      emit(state.copyWith(
        myFeatureActionStatus: GenericStatus.success,
        refreshController: !state.refreshController,
      ));
    } else {
      emit(state.copyWith(
        myFeatureActionStatus: GenericStatus.failure,
        myFeatureActionErrorMessage:
            LocalizationService.localization.errorCreatingMyFeature,
      ));
    }
  } on HttpException400 catch (e) {
    emit(state.copyWith(
      myFeatureActionStatus: GenericStatus.failure,
      myFeatureActionErrorMessage:
          e.message ?? LocalizationService.localization.errorCreatingMyFeature,
    ));
  } catch (e) {
    log('Error creating my feature: $e');
    emit(state.copyWith(
      myFeatureActionStatus: GenericStatus.failure,
      myFeatureActionErrorMessage:
          LocalizationService.localization.errorCreatingMyFeature,
    ));
  }
}
```

**Reset handlers (always include):**

```dart
void _onResetFlowStep(_ResetFlowStep event, Emitter<MyFeatureState> emit) {
  emit(state.copyWith(
    flowStep: GenericFlowStep.none,
    myFeatureActionStatus: GenericStatus.initial,
    myFeatureActionErrorMessage: null,
  ));
}

void _onReset(_Reset event, Emitter<MyFeatureState> emit) {
  emit(const MyFeatureState());
}

void _onRefreshMyFeatures(
    _RefreshMyFeatures event, Emitter<MyFeatureState> emit) {
  emit(state.copyWith(refreshController: !state.refreshController));
}
```

---

## Status Enums Reference

```dart
enum GenericStatus {
  initial,    // Before any action
  loading,    // Full load (first page, no prior data)
  filtering,  // Triggered by search/filter (data already showing)
  success,    // Operation completed
  failure,    // Operation failed
}

enum GenericFlowStep {
  none,           // Default idle state
  creatingItem,   // Create in progress
  updatingItem,   // Update in progress
  deletingItem,   // Delete in progress
}
```

Use `filtering` (not `loading`) when a search term is present and list already shows data.

---

## UI State That Belongs in the BLoC

Small UI flags that affect what the page shows live in the page's BLoC state, not in `setState`:

```dart
// state
@Default(false) bool isPasswordVisible,
@Default(false) bool isConfirmPasswordVisible,

// event
const factory SignInEvent.togglePasswordVisibility() = _TogglePasswordVisibility;

// handler
void _onTogglePasswordVisibility(
    _TogglePasswordVisibility event, Emitter<SignInState> emit) {
  emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
}
```

- Every password field has an eye button; the icon shows the **current** state (open eye = visible, crossed eye = hidden).
- Sign-up and password-reset forms have a **confirm-password** field validated with `Validators.confirmPassword`.
- `setState` stays for purely local widget mechanics (a `PagingController`, a debounce `Timer`, a `TextEditingController`).

---

## Reading a Sealed State or Event

Freezed 3+ no longer generates `when`/`map`. Use Dart's `switch`:

```dart
final label = switch (event) {
  _Init() => 'init',
  _FetchMyFeatures(:final pageKey) => 'page $pageKey',
  _ => 'other',
};
```

---

## Debouncing Events

For search-as-you-type handled **inside** a BLoC (instead of a `Timer` in the page), use the kit's transformer:

```dart
on<_SearchChanged>(
  _onSearchChanged,
  transformer: debounceSequential(const Duration(milliseconds: 500)),
);
```

`debounceSequential` waits until no new event arrived for the duration, handles only the latest one, and runs handlers one at a time.
