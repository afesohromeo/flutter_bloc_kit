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
App-bar back button (`context.pop()`, tooltip "Back"), for pages nested under another route. The icon uses the text colour; pass `color:` on a dark app bar.

### `AppBarMenu` / `AppBarMenuItem`
A page's app-bar actions: one action shows as its own icon button; two or more go behind a ⋮ menu. Destructive entries are drawn in the error colour.
```dart
actions: [
  AppBarMenu(items: [
    AppBarMenuItem(label: l10n.edit, icon: Icons.edit_outlined, onTap: _edit),
    AppBarMenuItem(label: l10n.delete, icon: Icons.delete_outline, destructive: true, onTap: _delete),
  ]),
],
```

### `Breadcrumb` / `BreadcrumbItem`
Where the page sits ("Projects › House › Stages › Walls"); every part but the last opens its page. When the line is too long, the middle folds into "…", keeping the first and the last two.
```dart
Breadcrumb(items: [
  BreadcrumbItem(l10n.projects, onTap: () => context.goNamed(projectsRouteName)),
  BreadcrumbItem(project.name, onTap: ...),
  BreadcrumbItem(stage.name),   // current page: no onTap
])
```

### `ContentLayout`
The scrolling body of a page: padded, centred, at most `maxWidth` (1200) wide, with pull-to-refresh when `onRefresh` is given. From `twoColumnsFrom` (840 px) it shows `main` and `side` as two columns; narrower, `side` goes below `main`, or behind a segmented switch when `sideLabels` are given.
```dart
ContentLayout(
  onRefresh: () async => bloc.add(const ProjectEvent.refresh()),
  main: [summaryCard, stagesCard],
  side: [activityCard, membersCard],
  sideLabels: [l10n.activity, l10n.members],
)
```

### `SegmentedPanels` / `SegmentedSwitch`
Secondary content one panel at a time behind a segmented switch (hidden panels stay alive). `SegmentedSwitch` is the switch alone, for pages that show the chosen panel themselves.

### `AuthFormLayout`
Body of form pages (welcome, sign-in, sign-up, password reset): title, optional subtitle, centred, scrollable, at most 420 px wide.

### `ReloadOnReturn`
Reloads a page when the user comes back to it from a child route (not when a dialog closes). See 07.

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

### `SubmitButton`
Full-width `PrimaryButton` for forms; while `isLoading` it shows a spinner and ignores taps; `onPressed: null` disables it.
```dart
SubmitButton(label: l10n.save, isLoading: state.flowStep == GenericFlowStep.creatingItem, onPressed: _submit)
```

### `PasswordVisibilityButton`
The eye button at the end of a password field (RULE-042). The icon shows the **current** state (open eye = visible, crossed eye = hidden); the tooltip says what a tap does. The state lives in the BLoC.
```dart
InputField(
  obscureText: !state.isPasswordVisible,
  suffixIcon: PasswordVisibilityButton(
    isVisible: state.isPasswordVisible,
    onPressed: () => bloc.add(const SignInEvent.togglePasswordVisibility()),
  ),
  ...
)
```

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

### `MoneyField`
An amount in a currency, typed in the app language; shows the currency symbol and validates with `parseMoney` (empty = no amount). Read the value with `parseMoney(controller.text, currencyCode)`, in **minor units**.
```dart
MoneyField(controller: _amount, currencyCode: 'XAF', labelText: l10n.amount)
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

## Filters and Sorting

### `FilterChips<T>` / `FilterPill` / `PickerPill<T>` / `FilterChoice<T>`
A row of filter pills, one chosen at a time, scrolling sideways when it doesn't fit; `PickerPill` opens a menu of choices ("All stages ▾"). Filters run **on the server** (13): selecting a pill dispatches the list's `refresh` event.
```dart
FilterChips<ItemStatus?>(
  keyPrefix: 'items.filter',
  choices: [FilterChoice(null, l10n.all), FilterChoice(ItemStatus.active, l10n.active)],
  selected: _status,
  onSelected: (status) { setState(() => _status = status); bloc.add(const ItemsEvent.refreshItems()); },
)
```

### `SortButton<T>`
An icon that opens the ways a list can be ordered, the current one checked.

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

### `showConfirmDialog`
Asks before a destructive action; returns `true` when the user confirms. Pass `cancelLabel` when "Cancel" would be ambiguous next to the action ("Keep order" beside "Cancel order").
```dart
if (await showConfirmDialog(context, title: l10n.removeMemberTitle, message: l10n.removeMemberMessage, confirmLabel: l10n.remove)) {
  bloc.add(MembersEvent.remove(member));
}
```

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

### `OneLineText`
Text on one line, shrunk to fit rather than wrapped (amounts like "20,650,000 FCFA" in narrow cards).

### `IgnoreIntrinsicHeight`
Inside an `IntrinsicHeight` row, lets a child (e.g. a portrait photo) fill the height the other children set instead of setting it.

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
| `formatMoney`, `formatMoneyShort`, `formatMoneyInput`, `parseMoney`, `currencyDigits`, `currencySymbol` | Money as **integer minor units** + ISO 4217 code: `formatMoney(1500000, 'XAF')` → "1,500,000 FCFA" (XAF has no minor units), `formatMoney(125050, 'EUR')` → "€1,250.50"; `formatMoneyShort` → "12.5 M FCFA"; `parseMoney` reads typed text back (null when invalid) |

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

---

## Device Providers (`data/device/`)

Platform APIs sit behind small classes, injected into repositories or BLoCs, so tests can mock them (15). The kit ships one example:

| Provider | Use |
|----------|-----|
| `ClipboardProvider` | `copyText(text)` |

Add others the same way when the app needs them (share sheet with `share_plus`, location with `geolocator`, camera, device info), each with its mock in `test/helpers/mocks.dart`.

