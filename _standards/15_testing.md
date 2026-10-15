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
│   ├── fixtures.dart           # sample models (anItem(), aPage())
│   └── field_helpers.dart      # isObscured, fieldText, autofillHintsOf, isReadOnly, …
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

### `field_helpers.dart`
Read a form field found by its key (the `TextField` inside an `InputField`):

| Helper | Returns |
|--------|---------|
| `isObscured(tester, key)` | whether the text is hidden (password fields, RULE-042) |
| `fieldText(tester, key)` | the text in the field |
| `autofillHintsOf(tester, key)` | its autofill hints |
| `isReadOnly(tester, key)` | whether it is read-only |
| `autofillContextsFinished(tester)` | what the page told the password manager: `true` = save the credentials, `false` = drop them |

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

---

## One End-to-End Test of the Core Flow

Unit and widget tests check pieces; one test checks that they fit together. Write **one test that walks the app's main flow from start to finish** (e.g. create → invite → act → review → see the result), and keep it green:
- **Serverpod apps:** an integration test in the server package that calls the endpoints in sequence (`withServerpod`, 14).
- **REST apps:** a widget test of the flow with mocked repositories, or an `integration_test` against a test backend.

---

## Screenshot Harness (`tool/screenshots/`)

Renders pages to PNG files at phone, tablet and desktop sizes, in any language. Not part of `flutter test`; run it when reviewing a design or before a release:

```bash
flutter test --update-goldens tool/screenshots/                         # English → out/*.png
flutter test --update-goldens --dart-define=LOCALE=fr tool/screenshots/ # French  → out/*_fr.png
```

- `harness.dart`: `loadFonts()` (Roboto and Material icons from the Flutter SDK; add the app's bundled font), `shot(tester, name, size, page, theme: ...)`, and the sizes `phone`, `tablet`, `desktop`.
- One file per group of screens (e.g. `kit_screens_test.dart`): pages driven by `MockBloc` states, exactly like widget tests.
- Look at the images: overflow stripes, text that wraps badly, colours that don't match the approved mockups. It already caught an invisible back button in the kit.
- `tool/screenshots/out/` is gitignored.

---

## Agent-Driven Checks (`lib/driver.dart`)

`lib/driver.dart` starts the app with the Flutter driver extension, so an agent can operate the running app (tap, read the screen) through the Dart MCP server. To let the agent type into fields, set `enableTextEntryEmulation: true` there (it blocks the real keyboard, so set it back for manual use).

```bash
flutter run --target lib/driver.dart
```

