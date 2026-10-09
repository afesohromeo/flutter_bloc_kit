# Testing

## Principles
- **Test first (TDD):** write the test, see it fail for the right reason, then write the code.
- Every new **BLoC** has `bloc_test` tests, every **repository** has unit tests with a mocked API provider, every **page** has at least one widget test (RULE-045).
- Tests never call a real backend or a real device API: API providers, repositories and device providers are **mocked** with `mocktail`.
- `flutter test` must be green and `flutter analyze` clean before a change is done.

**Dev dependencies (already in the kit):** `flutter_test`, `bloc_test`, `mocktail`.

---

## Layout

`test/` mirrors `lib/src/`:

```
test/
├── helpers/
│   ├── helpers.dart            # barrel for the helpers below
│   ├── pump_app.dart           # tester.pumpApp(widget), tester.pumpRouterApp(router)
│   ├── test_localization.dart  # setUpTestLocalization() → AppLocalizations
│   ├── mocks.dart              # one Mock class per API provider / repository / device provider
│   └── fixtures.dart           # sample models (anItem(), aPage())
├── core/
├── data/                       # API provider tests (Dio mocked)
├── domain/                     # repository tests
├── features/{feature}/
│   ├── bloc/{feature}_bloc_test.dart
│   └── views/{feature}_page_test.dart
└── shared/                     # components, utils, extensions
```

Imports in a test file:
```dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/my_app.dart';            // app barrel

import '../../../helpers/helpers.dart';          // test/ can't be reached with package:
```

---

## Naming
Group and test names read as a sentence, **Given / when / then**:

```dart
group('Given the items bloc', () {
  blocTest<ItemsBloc, ItemsState>(
    'when the first page loads then it emits loading then success',
    ...
  );
});
```

---

## Helpers

### `setUpTestLocalization()`
BLoCs and repositories read messages from `LocalizationService.localization`, which the app sets at startup. Tests set it once:

```dart
late AppLocalizations l10n;
setUpAll(() => l10n = setUpTestLocalization());   // English by default
```
Then compare against `l10n.errorLoadingItems`, never against a hardcoded string.

### `pumpApp` / `pumpRouterApp`
Wrap a widget in a `MaterialApp` with the app's localizations (and a router for pages that navigate):

```dart
await tester.pumpApp(
  BlocProvider<ItemsBloc>.value(value: bloc, child: const ItemsPage()),
);
```

### `mocks.dart`
```dart
class MockItemApiProvider extends Mock implements ItemApiProvider {}
class MockItemRepository extends Mock implements ItemRepository {}
class MockItemsBloc extends MockBloc<ItemsEvent, ItemsState> implements ItemsBloc {}
```

---

## Patterns

### BLoC
```dart
blocTest<ItemsBloc, ItemsState>(
  'when the repository fails then it emits failure with the list error',
  setUp: () => when(() => repository.fetchItems(0, keyword: null, size: any(named: 'size')))
      .thenThrow(Exception()),
  build: () => ItemsBloc(repository: repository),
  act: (bloc) => bloc.add(const ItemsEvent.fetchItems()),
  expect: () => [
    isA<ItemsState>().having((s) => s.itemsListStatus, 'status', GenericStatus.loading),
    isA<ItemsState>()
        .having((s) => s.itemsListStatus, 'status', GenericStatus.failure)
        .having((s) => s.itemsListError, 'error', l10n.errorLoadingItems),
  ],
);
```

### Repository
The API provider is injected through the constructor (RULE-044):
```dart
final apiProvider = MockItemApiProvider();
final repository = ItemRepository(apiProvider: apiProvider);
when(() => apiProvider.fetchItems(0, keyword: null, size: 20))
    .thenAnswer((_) async => AppApiResponse.fromJson(pageJson));
```

### Widget
- Drive the page with a `MockBloc` (`whenListen` / `when(() => bloc.state)`), not a real BLoC, unless the test is about the wiring.
- Find widgets by **`Key`** (declare keys as `static const` on the page: `ItemsPage.searchFieldKey`) or by localized text (`l10n.itemsTitle`).
- Check behaviour the user sees: the empty state, the error state with retry, a dialog after a failed action.

### Golden rules
- No `sleep`/real timers: use `tester.pump(duration)` and `fakeAsync`.
- One behaviour per test; the name says which.
- A bug fix starts with a test that reproduces the bug.
