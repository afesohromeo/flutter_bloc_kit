# Inconsistencies & Refactoring Backlog

Known gaps in the kit itself. Don't fix them opportunistically during unrelated work; each needs its own planned change.

---

## Fixed in v2 (2026-10)

| Item | Fix |
|------|-----|
| A real JWT (`fakeToken`) committed in `constant.dart` | Removed |
| `AppApiResponse.data2` untyped, cast at every call site | `data2AsMap` getter |
| `errorr_widget.dart` / `ErrorrWidget` | `ErrorStateWidget` (`ErrorWidget` is taken by Flutter) |
| `scafold_*` file names | `scaffold_*` |
| API layer described by the standards but missing from the kit | `ApiProvider`, `DioInterceptor`, `ApiErrorHandler`, `PaginatedList<T>` |
| Connectivity check always returned `true` | Real check (interface + internet probe), web-safe |
| Validators commented out | `Validators` (static, localized) |
| Empty test folder | Helpers + 74 tests |
| `ScaffoldWrapper` never showed its bottom navigation bar | Fixed, with a regression test |
| Dates always formatted in French | Follow the app language (`Intl.defaultLocale`) |
| `make i18n` called `intl_utils`, which isn't installed | `flutter gen-l10n` |
| Android build no longer worked with Flutter 3.47 (Gradle 8.10) | Gradle 9.3.1, AGP 9.1.1, Kotlin 2.3.21, Java 17 |
| No `web/` platform folder although the kit contains web code | `web/` added |
| Repositories couldn't be mocked (M-004) | API providers injected through the constructor; `mocktail` mocks concrete classes |

---

## Open

### K-001: Naming leftovers in widget parameters
- `PrimaryButton.inkRaduis` (should be `inkRadius`)
- `ScaffoldWrapper.floatingButtonpadding` (should be `floatingButtonPadding`, like `ScaffoldWrapperProps`)
- `CustomPaginatedList.seperator` (should be `separator`)
- `MyAppColors.black1` (vague: the main text colour)

**Why not fixed yet:** every app built from the kit uses these names; renaming needs a planned migration note.

### K-002: `InputField.onChanged` only reports valid input
`onChanged` is skipped when the `validator` returns an error. Surprising for fields that must react to every keystroke; documented in 08. Consider an explicit option.

### K-004: `app_theme_kit` issues (separate package)
Found in Plotwatch: the text theme colours body text with the secondary colour, and the font is downloaded at runtime (`google_fonts`). Fix in the `app_theme_kit` repository.

### K-005: `GenericFlowStep` has no "loading details" step
Removed in v2 because nothing used it; add it back (in 02 too) if a detail page needs its own flow step.
