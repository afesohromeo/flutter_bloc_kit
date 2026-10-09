# Shared Components Reference

**Location:** `lib/src/shared/components/` (widgets) and `lib/src/shared/utils/` (helpers). Everything is exported by the app barrel.

Always use these before building a custom equivalent. When a component needs a new option, add it here (with a test) rather than copying the widget.

---

## Page Structure

### `ResponsiveScaffoldWrapper` ⭐ (every page, RULE-043)
```dart
ResponsiveScaffoldWrapper(
  props: ScaffoldWrapperProps(
    title: Text(l10n.itemsTitle, style: context.textTheme.titleLarge),
    leading: const CustomBackButton(),   // or a menu button that opens the drawer
    showDrawer: false,                   // default true
    appBarBgColor: customColors.background,
    elevation: 0,
    actions: [...],
    hasAppbar: true,
    showFloatingButton: false, onPressed: ..., buttonIcon: ...,
    showBottomNav: false, bottomNav: ...,
    resizeToAvoidBottomInset: true,
  ),
  mobileBody: _body(),
  tabletBody: _body(),    // optional, defaults to mobileBody
  desktopBody: _body(),   // optional, defaults to tabletBody/mobileBody
)
```
The drawer is an overlay on mobile/tablet and a fixed 280 px sidebar on desktop. `ScaffoldWrapper` is its building block; pages never use it directly.

### `AppDrawer` / `DrawerTile`
`AppDrawer` lists the top-level destinations (one `DrawerTile` each) and highlights the current route. Edit `app_drawer.dart` when you add a destination.
```dart
DrawerTile(title: l10n.itemsTitle, iconData: Icons.list_alt_outlined,
    selected: currentRoute == itemsRouteName, onTap: () => open(itemsRouteName), isVisible: true)
```

### `ScaffoldWithNav` / `AppBottomNavBar` / `NavItem` (optional bottom tabs)
For apps with persistent tabs (`StatefulShellRoute.indexedStack`, see 07):
```dart
ScaffoldWithNav(
  navigationShell: shell,
  items: const [
    NavItem(icon: Icons.map_outlined, activeIcon: Icons.map, label: '...'),
  ],
)
```

### `CustomBackButton`
App-bar back button (`context.pop()`), for pages nested under another route.

### `ResponsiveDialogWrapper`
```dart
ResponsiveDialogWrapper(maxDialogWidth: 500, child: MyDialogContent())
```

### `ResponsiveLayout`
```dart
ResponsiveLayout.isMobile(context)   // shortest side < 600 or width ≤ 800
ResponsiveLayout.isTablet(context)   // 600 ≤ shortest side < 1100
ResponsiveLayout.isDesktop(context)  // shortest side ≥ 1100
```

---

## Buttons

### `PrimaryButton`
```dart
PrimaryButton(
  onPressed: _onSubmit,          // null = disabled
  height: 48,
  width: 260,                    // mobile width
  w2: 320,                       // optional: wider screens
  withBg: true,                  // gradient fill (default)
  buttonColor: customColors.error,
  child: Text(l10n.save, style: context.textTheme.titleMedium?.copyWith(color: customColors.background)),
)
```

---

## Form Fields

### `InputField`
```dart
InputField(
  controller: _emailController,
  labelText: l10n.labelEmail,
  validator: (value) => Validators.email(value, l10n),
  keyboardType: TextInputType.emailAddress,
  autofillHints: const [AutofillHints.email],   // RULE-042
  obscureText: false,
  suffixIcon: IconButton(...),
)
```
Note: `onChanged` only receives values that pass `validator`.

### `SearchInputField`
```dart
SearchInputField(
  onChanged: _onSearchChanged,     // debounce 500 ms in the page (06) or the BLoC (02)
  labelText: l10n.itemsSearchHint,
  focusNode: _focusNode,           // optional
  onEditingComplete: _search,      // optional: keyboard "done"
  onSuffixPressed: _search,        // optional: makes the search icon a button
)
```

### `PhoneNumberFormField`
International phone input (`intl_phone_field`), validated for the selected country.
```dart
PhoneNumberFormField(parentContext: context, initialCountryCode: 'CM',
    phoneNumberController: _phone, isRequired: true, onChanged: (number) => ...)
```

### `DatePickerField` / `TimePickerField`
```dart
DatePickerField(labelText: l10n.startDate, value: _start, onChanged: (date) => ..., withTime: false)
TimePickerField(labelText: l10n.time, value: _time, onChanged: (time) => ..., use24HourFormat: true)
```
Use `formatDateForApi(date)` when sending a date to the API.

### `SearchableDropdownField<T>`
Bottom-sheet picker with search, for lists loaded from the API:
```dart
SearchableDropdownField<Country>(
  items: countries, selectedValue: _country, itemToString: (c) => c.name,
  onChanged: (c) => ..., labelText: l10n.country,
  isLoading: state.countriesStatus == GenericStatus.loading,
  isFailure: state.countriesStatus == GenericStatus.failure,
  onRetry: () => bloc.add(const ProfileEvent.fetchCountries()),
)
```

### `DynamicDropdown<T>`
`DropdownButtonFormField` with loading/failure/empty states driven by a status value.

### `MultiSelectField<T>`
```dart
MultiSelectField<String>(items: options, selectedValues: _selected,
    onChanged: (values) => ..., getDisplayText: (v) => v, labelText: l10n.permissions)
```

---

## Lists

### `CustomPaginatedList<T>` / `CustomPaginatedGridList<T>`
Infinite-scroll list/grid around a `PagingController` (13). See `ItemsPage` for the full wiring.
```dart
CustomPaginatedList<Item>(
  pagingController: _pagingController,
  seperator: const Gap.vertical(height: 8),
  pagedChildBuilderDelegate: PagedChildBuilderDelegate<Item>(itemBuilder: ...),
)
```

---

## Feedback & States

| Situation | Component |
|-----------|-----------|
| First load | `ShimmerSkeleton` + `SkeletonBox` (or `LoadingWidget(loadingText: l10n.loading)`) |
| Empty list | `EmptyWidget(emptyText: l10n.itemsEmptyState, onPressed: refresh)` |
| Failed load | `ErrorStateWidget(errorMessage: ..., onPressed: retry)` (button text defaults to "Try again") |
| Action in a dialog | `ModalProgressHUD(inAsyncCall: state.flowStep == GenericFlowStep.creatingItem, child: ...)` (package `modal_progress_hud_nsn`) |
| Result of an action | `DialogUtils.handleSuccess` / `handleFailure` (shows `Congratulations` / `ErrorDialog`) |
| Small spinner on a coloured button | `AdaptiveWhiteProgressIndicator` |

### `ShimmerSkeleton` / `SkeletonBox`
```dart
ShimmerSkeleton(
  child: Column(children: [
    const SkeletonBox(height: 56, radius: 12),
    const SkeletonBox.circle(size: 40),
  ]),
)
```
Stays still when the system asks for reduced animations.

### `DialogUtils`
```dart
await DialogUtils.handleSuccess(context, l10n.itemCreated,
    postActions: [() => bloc.add(const MyFeatureEvent.resetFlowStep())],
    shouldPopDialog: true);   // closes the calling dialog first

await DialogUtils.handleFailure(context, state.myFeatureActionErrorMessage ?? l10n.errorSavingMyFeature,
    postActions: [() => bloc.add(const MyFeatureEvent.resetFlowStep())]);
```
Success dialogs close after 3 s, error dialogs after 10 s. Never use SnackBars (RULE-039).

---

## Layout Helpers

### `Gap`
```dart
const Gap.vertical(height: 12)          // h2: optional height on wider screens (default ×1.8)
const Gap.horizontal(width: 8)          // w2: same for width
const Gap.verticalSliver(height: 12)    // inside CustomScrollView
const Gap.horizontalSliver(width: 8)
```

### `AppDivider`
A thin divider in `customColors.surface`.

### `MeasureSize`
Reports its child's size after layout (e.g. to size a bottom sheet to its content):
```dart
MeasureSize(onChange: (size) => setState(() => _height = size.height), child: ...)
```

---

## Utilities (`shared/utils/`)

| Helper | Use |
|--------|-----|
| `Validators` | `email`, `password`, `confirmPassword`, `fullName`, `required`: localized messages (12) |
| `debounceSequential(duration)` | Event transformer for search-as-you-type in a BLoC (02) |
| `NetworkConnectivity.instance` | `isOnline()`, `onConnectivityChanged` (interface + real internet check; web-safe) |
| `SecureStorageHelper` | `saveToken` / `getToken` / `deleteToken`, `saveUser` / `getUser`, `getFlag` / `setFlag`, `clearAll` |
| `LocalizationService.localization` | `AppLocalizations` for code without a `BuildContext` |
| `formatDate`, `formatDateForApi`, `convertJsonDate`, `formatPrice`, `convertToDouble` | Dates and numbers (in the app's language) |
| `downloadFile(bytes, name)` | Save a file (browser download on web, Downloads folder on desktop) |
| `GenericStatus`, `GenericFlowStep` | BLoC status enums (02) |

---

## Extensions (`shared/extensions/`)

```dart
context.textTheme / context.colorScheme / context.theme / context.brightness
context.mediaQuery / context.screenSize
context.localization          // same as LocalizationService.localization
widgets.divide(separator: const Gap.vertical(height: 8))   // Iterable<Widget>
```

---

## Colours

`customColors` (defined in `shared/utils/constant.dart`, type `MyAppColors`): `primary`, `secondary`, `background`, `surface`, `error`, `success`, `warning`, `black1`. Replace the values with the app's brand when a project starts; never use `Colors.xxx` in pages or components (RULE-038).
