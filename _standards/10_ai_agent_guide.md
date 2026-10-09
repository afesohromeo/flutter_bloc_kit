# AI Agent Guide — How to Work on This Codebase

This is the step-by-step procedural guide for implementing any new feature.
Follow every step in order. Do not skip layers.

---

## Before You Start

1. Read `_standards/README.md` for the quick-reference stack
2. Find an existing similar feature and read its files as a reference implementation
3. Never invent patterns — if unsure, check an existing feature first

---

## Step 1 — Create the Domain Model

**File:** `lib/src/domain/models/{feature}.dart`

- Use `@freezed`
- Add `part '{feature}.freezed.dart';`
- `fromJson` as a factory constructor
- `createPayload` and `updatePayload` as **static methods**
- If the model needs any getter/method: add `const MyModel._();`
- Use `int.tryParse(json['id'].toString())` for int fields
- Use `convertJsonDate(json['date'])` for DateTime fields
- For enum fields: call `MyEnum.fromString(json['field'])`
- Strip nulls from payloads: `..removeWhere((key, value) => value == null)`

See: [05_models.md](05_models.md)

---

## Step 2 — Create the API Provider

**File:** `lib/src/data/api/{domain}/{feature}_api_provider.dart`

- Dio getter: `Dio get _dio => ApiProvider().dioExtSagePaie!;`
- One method per HTTP operation: `fetch`, `fetchAll`, `create`, `update`, `delete`
- Query params: use `..removeWhere((key, value) => value == null)`
- Body: `data: jsonEncode(data)` for JSON, `FormData.fromMap(...)` for file uploads
- Every method: `try { ... } on DioException catch (e) { throw ApiErrorHandler.handle(e); }`
- Return `AppApiResponse` from every method

See: [04_api_repository.md](04_api_repository.md)

---

## Step 3 — Create the Repository

**File:** `lib/src/domain/repository/{feature}_repository.dart`

- Instantiate provider directly: `final XApiProvider _apiProvider = XApiProvider();`
- Return types: `PaginatedList?` for lists, `Model?` for single objects, `bool` for delete
- Map `apiResponse.data!.content` → `List<Model>.from(...map(Model.fromJson))`
- Use `apiResponse.data2` for single-object responses — cast explicitly
- Always: `log('Error: $e'); rethrow;` in every catch block
- Error messages: `LocalizationService.localization.*` only

See: [04_api_repository.md](04_api_repository.md)

---

## Step 4 — Create the BLoC (3 files)

**Files:**
- `lib/src/features/{feature}/bloc/{feature}_bloc.dart`
- `lib/src/features/{feature}/bloc/{feature}_event.dart`
- `lib/src/features/{feature}/bloc/{feature}_state.dart`

### Event file checklist
- `part of '{feature}_bloc.dart';`
- `@freezed` class
- Include: `.init()`, `.fetch{Items}()`, `.refresh{Items}()`, `.create{Item}()`, `.update{Item}()`, `.delete{Item}()`, `.resetFlowStep()`, `.reset()`
- All parameters: named + typed — never `Map<String, dynamic>`
- Use `@Default(0) int pageKey` for pagination events

### State file checklist
- `part of '{feature}_bloc.dart';`
- `@freezed` class, single constructor
- Include all list fields: `{items}`, `paginated{Items}`, `max{Items}`, `refreshController`, `pageKey`, `pageSize`, `totalCount`
- Include `GenericFlowStep flowStep`
- Include scoped status fields: `{feature}Status`, `{feature}ActionStatus`
- Include scoped error fields: `{feature}ListErrorMessage`, `{feature}ActionErrorMessage`

### BLoC class checklist
- `part '{feature}_event.dart'; part '{feature}_state.dart'; part '{feature}_bloc.freezed.dart';`
- Constructor: inject repository as named param, call `super(const {Feature}State())`
- Register all handlers in constructor with `on<_EventName>(_handlerMethod)`
- Handler signature: `Future<void> _on{Event}(_PrivateEvent event, Emitter<State> emit) async`
- Every fetch handler: loading → repository call → success/null-failure → HttpException400 catch → generic catch
- Every CRUD handler: set `flowStep` in loading emit, flip `refreshController` on success
- Always include `_onResetFlowStep` and `_onReset`

See: [02_bloc_patterns.md](02_bloc_patterns.md)

---

## Step 5 — Create the DataSource

**File:** `lib/src/features/{feature}/data_sources/{feature}_data_source.dart`

- Extend `AsyncDataTableSource`
- Constructor receives: `{Feature}Bloc bloc`, `BuildContext context`, filter params
- `getRows(startIndex, count)`:
  - Calculate `pageKey = startIndex ~/ count`
  - Cancel previous `_subscription`
  - Create `Completer<AsyncRowsResponse>`
  - Subscribe to `_bloc.stream`
  - On success state: build rows, complete with `AsyncRowsResponse(state.totalCount, rows)`
  - On failure state: `completer.completeError(errorMessage)`
  - After completing: cancel subscription
  - Trigger: `_bloc.add(FetchEvent(pageKey: pageKey, size: count, ...))`
- `dispose()`: cancel subscription, call `super.dispose()`

See: [06_ui_patterns.md](06_ui_patterns.md)

---

## Step 6 — Create the Tile

**File:** `lib/src/features/{feature}/views/widgets/{feature}_tile.dart`

```dart
class MyFeatureTile {
  const MyFeatureTile({required this.data, this.onDelete, this.onEdit});

  final MyFeature data;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  DataRow buildDataRow(BuildContext context) {
    return DataRow(cells: [
      DataCell(Text(data.name ?? '')),
      DataCell(Text(data.code ?? '')),
      DataCell(Row(children: [
        if (onEdit != null)
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
        if (onDelete != null)
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
      ])),
    ]);
  }
}
```

---

## Step 7 — Create the Dialogs

**Files:**
- `lib/src/features/{feature}/views/widgets/create_update_{feature}_dialog.dart`
- `lib/src/features/{feature}/views/widgets/delete_{feature}_dialog.dart`

Create/Update dialog checklist:
- `StatefulWidget` with `TextEditingController`s
- Detect mode: `bool get _isUpdateMode => widget.item != null`
- On submit: build `MyFeature(...)` object, add typed event to BLoC
- `BlocConsumer` listener: check `flowStep` + `actionStatus` for success/failure
- On success: `DialogUtils.handleSuccess(...)` with `postActions: [resetFlowStep]`, `shouldPopDialog: true`
- On failure: `DialogUtils.handleFailure(...)` with `postActions: [resetFlowStep]`, `shouldPopDialog: false`
- Builder: `ModalProgressHUD(inAsyncCall: flowStep == GenericFlowStep.creatingItem, ...)`
- Dialog style: `contentPadding: EdgeInsets.zero`, top divider thickness 2, bottom thickness 1.5

Delete dialog checklist:
- `StatelessWidget`
- On confirm: add `.deleteMyFeature(item)` event
- On success: `DialogUtils.handleSuccess` with `postActions: [resetFlowStep, refresh]`, `shouldPopDialog: true`
- `ModalProgressHUD(inAsyncCall: flowStep == GenericFlowStep.deletingItem)`

See: [06_ui_patterns.md](06_ui_patterns.md)

---

## Step 8 — Create the Page

**File:** `lib/src/features/{feature}/views/{feature}_page.dart`

- `StatefulWidget`
- Fields: `_dataSource`, `_debounce`, `_tableKey = UniqueKey()`, `_searchTerm`, `_rowsPerPage = 10`
- `initState`: call `_initDataSource()`
- `_initDataSource()`: dispose old datasource, create new one
- `_onSearchChanged()`: 500ms debounce with `Timer`, replace `_tableKey`, call `_initDataSource()`
- `_showCreateDialog()`: capture root context first, then `showDialog` with `BlocProvider.value`
- `build()`: `BlocConsumer` with `listenWhen`/`buildWhen`
  - Listener: if `refreshController` changed → `_onRefresh()`
  - Builder: `Column` → search bar + action button row → `Expanded(AsyncPaginatedDataTable2(...))`
- `dispose()`: `_dataSource?.dispose()`, `_debounce?.cancel()`

See: [06_ui_patterns.md](06_ui_patterns.md)

---

## Step 9 — Register the BLoC

In the appropriate parent widget or `BlocProvider` tree, provide the new BLoC:

```dart
BlocProvider(
  create: (context) => MyFeatureBloc(
    repository: MyFeatureRepository(),
  )..add(const MyFeatureEvent.init()),
  child: MyFeaturePage(),
)
```

---

## Step 10 — Register the Route

1. Add to `lib/src/core/routing/route_names.dart`:
```dart
const String myFeatureRouteName = 'my-feature';
const String myFeaturePage = '/my-feature';
```

2. Add to `shellSubRoutes` in `lib/src/core/routing/route_manager.dart`:
```dart
GoRoute(
  name: myFeatureRouteName,
  path: myFeaturePage,
  pageBuilder: (context, state) => NoTransitionPage<void>(
    key: state.pageKey,
    child: const MyFeaturePage(),
  ),
),
```

3. Add to `app_drawer.dart` if it should appear in the navigation drawer.

---

## What to Avoid

| Do NOT | Instead |
|--------|---------|
| Build `Map<String, dynamic>` in UI layer | Use model static payload builders |
| Put business logic in a page widget | Put it in the BLoC handler |
| Call repository directly from UI | Always go through BLoC events |
| Call one BLoC from another BLoC | Use repositories as shared data source |
| Use positional parameters in events | Always use named parameters |
| **Hardcode any text (UI, errors, logs)** | **Add to ARB files, use `l10n.*` (widgets) or `LocalizationService.localization.*` (BLoCs/repos)** ⭐ |
| Use `context` after `async` gap | Check `context.mounted` first |
| Skip `listenWhen`/`buildWhen` | Always provide both selectors |
| Create a `DropdownButtonFormField` without `isExpanded: true` | Add `isExpanded: true` |
| Use `DateTime.parse()` on API data | Use `convertJsonDate()` |
| Swallow exceptions in repository | Always `log + rethrow` |
| Build a new shared widget for a one-off | Check `shared/components/` first |

**See comprehensive i18n workflow:** [12_internationalization.md](12_internationalization.md)

---

## Code Generation

After adding new `@freezed` classes or modifying existing ones, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This regenerates all `.freezed.dart` files.
