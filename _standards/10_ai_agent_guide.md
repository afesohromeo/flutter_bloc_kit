# AI Agent Guide: How to Work on a Kit App

The step-by-step procedure for implementing a feature. Follow every step in order; don't skip layers.

---

## Before You Start

1. Read `README.md` (quick reference) and `09_normalization_rules.md` (RULE-001 to RULE-046).
2. **Present a plan and wait for the developer's approval** before writing code; save the approved plan in `doc/`.
3. Read the **reference implementation** and copy its shape. In the kit it is the `items` feature:

| Layer | Reference file |
|-------|----------------|
| Model | `lib/src/domain/models/item.dart` |
| API provider | `lib/src/data/api/items/item_api_provider.dart` |
| Repository | `lib/src/domain/repository/item_repository.dart` |
| BLoC (infinite-scroll list) | `lib/src/features/items/bloc/` |
| Page | `lib/src/features/items/views/items_page.dart` |
| Route | `ItemsPage` under `homeRouteName` in `lib/src/core/routing/route_manager.dart` |
| Tests | `test/domain/repository/item_repository_test.dart`, `test/features/items/` |

In an app built from the kit, the first real feature replaces `items`; from then on, use the closest existing feature as the reference.

4. Never invent patterns. If unsure, check the reference feature or ask.
5. Code generation (`make codegen`, `make i18n`) is run by the developer (RULE-046): say which command to run and wait.

---

## Step 0: Tests First
For each layer below, write the test first (15), run it, see it fail for the right reason, then write the code.

---

## Step 1: Model
**File:** `lib/src/domain/models/{feature}.dart` → export it from `domain/models/models.dart`.
- `@freezed sealed class`, `part '{feature}.freezed.dart';`
- `factory X.fromJson(Map<String, dynamic> json)` written by hand: `int.tryParse(json['id'].toString())`, `convertJsonDate(json['date'])`, enums via `fromString`
- `createPayload` / `updatePayload` as **static** methods, nulls stripped
- Getters or methods → add `const X._();`

See [05_models.md](05_models.md). (Serverpod apps: models are generated, see [14_serverpod.md](14_serverpod.md).)

---

## Step 2: API Provider
**File:** `lib/src/data/api/{domain}/{feature}_api_provider.dart` → export from the folder barrel and `data/api/api.dart`.
- `Dio get _dio => ApiProvider().dio;`
- One method per HTTP call, returning `AppApiResponse`
- Query parameters stripped of nulls; bodies `jsonEncode(data)`; uploads `FormData`
- `on DioException catch (e) { throw ApiErrorHandler.handle(e); }`

See [04_api_repository.md](04_api_repository.md).

---

## Step 3: Repository
**File:** `lib/src/domain/repository/{feature}_repository.dart` → export from `domain/repository/repository.dart`.
- API provider injected: `XRepository({XApiProvider? apiProvider}) : _apiProvider = apiProvider ?? XApiProvider();`
- Lists → `PaginatedList<X>?`; create/update → `X?`; delete → `bool`
- `log('Error ...: $e'); rethrow;` in every catch
- Messages from `LocalizationService.localization.*`, one key per error case
- Register it in `Application` with a `RepositoryProvider`

---

## Step 4: BLoC (3 files)
**Files:** `features/{feature}/bloc/{feature}_bloc.dart`, `_event.dart`, `_state.dart`.
- Infinite-scroll list → follow [13_mobile_pagination.md](13_mobile_pagination.md) (events `fetchX` / `refreshX`, seven `x*` state fields)
- CRUD actions → follow [02_bloc_patterns.md](02_bloc_patterns.md) (`GenericFlowStep`, action status, `resetFlowStep`, `reset`)
- Repository injected through the constructor
- 5-step handlers: loading → repository → null check → success → typed catches (`HttpException400` with `e.message ?? l10n.errorX`, `HttpException401`, `NetworkException`) then generic catch with `log`
- Debounced events: `transformer: debounceSequential(...)`

---

## Step 5: Page
**File:** `features/{feature}/views/{feature}_page.dart` (+ `views/widgets/` for cards, dialogs).
- Root widget: `ResponsiveScaffoldWrapper` (RULE-043)
- `BlocConsumer` with `listenWhen` / `buildWhen`
- Lists: `PagingController` + `CustomPaginatedList`; first load `ShimmerSkeleton`, empty `EmptyWidget`, error `ErrorStateWidget`
- Actions: dialogs with `ModalProgressHUD` driven by `flowStep`; results through `DialogUtils` (never SnackBars)
- Text from `l10n`, colours from `customColors`, styles from `context.textTheme`
- Keys for widgets the tests need: `static const searchFieldKey = Key('itemsPage.searchField');`
- Export the page from the feature barrel; export the feature barrel from `features/features.dart`

See [06_ui_patterns.md](06_ui_patterns.md) and [08_shared_components.md](08_shared_components.md).

---

## Step 6: Route
1. Name in `route_names.dart`, path in `route_paths.dart`.
2. `GoRoute` with `NoTransitionPage`, **nested under its parent route**; the page's BLoC is created in the route:
```dart
GoRoute(
  name: itemsRouteName,
  path: itemsPage,
  pageBuilder: (context, state) => NoTransitionPage<void>(
    key: state.pageKey,
    child: BlocProvider(
      create: (context) => ItemsBloc(repository: context.read<ItemRepository>()),
      child: const ItemsPage(),
    ),
  ),
),
```
3. Navigate with `context.goNamed(...)`.
4. Add a `DrawerTile` in `AppDrawer` (or a tab) if it is a top-level destination.

See [07_routing.md](07_routing.md).

---

## Step 7: Strings
Add every new key to `app_en.arb` (with `@key` description) and `app_fr.arb`, then ask the developer to run `make i18n`. See [12_internationalization.md](12_internationalization.md).

---

## Step 8: Check
`make check` (format, analyze, test) must pass. Then report what changed and what was verified.

---

## What to Avoid

| Do NOT | Instead |
|--------|---------|
| Build `Map<String, dynamic>` in the UI | Model static payload builders |
| Put business logic in a page | BLoC handlers |
| Call a repository from the UI | BLoC events |
| Call one BLoC from another | Share data through repositories |
| Positional parameters in events | Named parameters |
| Hardcode any text | ARB keys, one per error case |
| Use `context` after an `async` gap | Check `context.mounted` first |
| `Colors.xxx` / bare `TextStyle` | `customColors` / `context.textTheme` |
| SnackBars | `DialogUtils` |
| `context.go('/path')` | `context.goNamed(name)` |
| Deep or relative imports | The app barrel |
| `DateTime.parse()` on API data | `convertJsonDate()` |
| Swallow exceptions in a repository | `log` + `rethrow` |
| A new shared widget for a one-off | Check `shared/components/` first |
| `pumpAndSettle` with a shimmer on screen | `pump(duration)` a few times |
