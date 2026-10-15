# Changelog

## 2.1.0 (2026-10)

What Plotwatch added to the standards, the agent setup and the shared components, made generic. Plan: [`doc/kit-v2.1-plan.md`](doc/kit-v2.1-plan.md).

### Added
- Components: `SubmitButton`, `PasswordVisibilityButton`, `showConfirmDialog`, `ReloadOnReturn`, `FilterChips` / `FilterPill` / `PickerPill` / `FilterChoice`, `SortButton`, `AppBarMenu` / `AppBarMenuItem`, `Breadcrumb` / `BreadcrumbItem`, `ContentLayout`, `SegmentedPanels` / `SegmentedSwitch`, `AuthFormLayout`, `OneLineText`, `IgnoreIntrinsicHeight`, `MoneyField`.
- Money in integer minor units: `formatMoney`, `formatMoneyShort`, `formatMoneyInput`, `parseMoney`, `currencyDigits`, `currencySymbol`.
- `data/device/` with `ClipboardProvider` (platform APIs behind mockable classes).
- l10n keys `labelColon` (French space before the colon), `back`, `showPassword`, `hidePassword`, `sortAction`, `moreActions`, `breadcrumbLabel`, `validateAmountInvalid`.
- `lib/driver.dart`: Flutter driver entry point so an agent can drive the running app through the Dart MCP server.
- Screenshot harness (`tool/screenshots/`): renders screens on phone, tablet and desktop, in English or French, with real fonts.
- Test helpers `test/helpers/field_helpers.dart`; 134 tests.
- `_standards/16_release_checklist.md`; RULE-047 to RULE-051; new sections in 07 (`ReloadOnReturn`), 08 (the components above), 12 (`labelColon`, ICU plurals, the French pass), 14 (Serverpod skills and MCP, who runs what, `client.auth.restore()`, server URL, deployment, Google sign-in and account linking, two pitfalls) and 15 (end-to-end test, screenshot harness, agent-driven checks).
- `CLAUDE.md`: UI follows the approved design, batching long test runs, the driver, the release checklist. `.claude/SKILLS.md`: skill sources and the Serverpod MCP.

### Fixed
- `CustomBackButton` drew its icon in the background colour, invisible on a light app bar; it now uses the text colour, takes `color:` and has a "Back" tooltip.

## 2.0.0 (2026-10)

The kit becomes the single source of truth for new apps: code, engineering standards and agent setup, refreshed with what PlusLocate, SmartDrive and Plotwatch learned since April 2026. Plan: [`doc/kit-refresh-plan.md`](doc/kit-refresh-plan.md).

### Added
- `_standards/` (01–15): generic versions of the project standards, plus conventions from code review (RULE-036 to RULE-046), `14_serverpod.md` and `15_testing.md`.
- API layer: `ApiProvider`, `DioInterceptor`, `ApiErrorHandler` with `HttpException400/401/410` and `NetworkException`, `AppApiResponse.data2AsMap`, `Pagination`, `PaginatedList<T>`, `Environment.baseUrl`.
- Reference feature `items` (demo data without `BASE_URL`), placeholder home page, working drawer.
- `Validators`, `debounceSequential`, real connectivity check (`NetworkConnectivity`), `GoRouterRefreshStream`, crash-reporting hook `AppInitializer.recordError`.
- Components: `ShimmerSkeleton` / `SkeletonBox`, `MeasureSize`, `AppBottomNavBar` / `ScaffoldWithNav` / `NavItem`; `SearchInputField` focus, editing-complete and tappable suffix; `InputField.autofillHints`.
- Tests (74) with `bloc_test`, `mocktail` and helpers in `test/helpers/`.
- Web platform (`web/`): the kit already contained web-specific code and desktop layouts.
- `CLAUDE.md` template, `.claude/settings.json`, `.claude/SKILLS.md`; `make format`, `make analyze`, `make test`, `make check`.

### Changed
- Freezed 4 (classes are `sealed`; no `when`/`map`), go_router 18, flutter_secure_storage 11, flutter_lints 6, Dart ≥ 3.13.
- Android: Gradle 9.3.1, AGP 9.1.1, Kotlin 2.3.21, Java 17.
- `SecureStorageHelper` returns `null` for missing values, typed parameters, `getFlag` / `setFlag`.
- Dates format in the app's language instead of always French.
- `GenericFlowStep` is `none / creatingItem / updatingItem / deletingItem`.

### Fixed
- `ScaffoldWrapper` never showed its bottom navigation bar.
- `make i18n` called `intl_utils`, which isn't installed.
- `showSuccessErrorDialog` returned a future without `await` inside `try`.
- Components barrel was missing four widgets.

### Removed
- A committed JWT (`fakeToken`), counter demo `HomeBloc`, `AuthCheckHelper`, `BlocResetHelper`, `LocalizationWrapper`, `RouterExtensions`, `ActionStatus`, unused packages, commented-out code, the phone field's Cameroon-only "starts with 6" rule.

### Renamed (breaking for code copied from v1)
- `ErrorrWidget` → `ErrorStateWidget` (`ErrorWidget` is Flutter's own class).
- `scafold_wrapper.dart`, `scafold_wrapper_props.dart`, `responsive_scafold_wrapper.dart` → `scaffold_*` (class names unchanged).
