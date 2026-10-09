# Shared Components Reference

**Location:** `lib/src/shared/components/`

Always prefer shared components over building custom equivalents.

---

## Buttons

### `PrimaryButton`
Main action button with gradient fill and responsive width.

```dart
PrimaryButton(
  onPressed: _onSubmit,          // null = disabled state
  child: Text(l10n.save),
  height: 40,                    // optional
  width: 120,                    // optional — mobile width
  w2: 160,                       // optional — desktop width
  withBg: true,                  // default: true (gradient bg)
  buttonColor: customColors.error, // override color
)
```

---

## Text Inputs

### `InputField`
Standard elevated text field.

```dart
InputField(
  controller: _nameController,
  labelText: l10n.name,
  validator: (v) => v == null || v.isEmpty ? l10n.requiredField : null,
  keyboardType: TextInputType.text,
  obscureText: false,
  readOnly: false,
  enabled: true,
  maxlines: 1,
  prefixIcon: Icon(Icons.person),
  suffixIcon: IconButton(...),
  hintText: l10n.enterName,
)
```

### `SearchInputField`
Pre-styled search box, pass `onChanged` for debouncing at the page level.

```dart
SearchInputField(
  onChanged: _onSearchChanged,
  labelText: l10n.search,
)
```

---

## Dropdowns

### `SelectField`
Styled `DropdownButtonFormField`. **Always include `isExpanded: true`** (already baked in).

```dart
SelectField<Department>(
  value: _selectedDepartment,
  items: departments.map((d) =>
    DropdownMenuItem(value: d, child: Text(d.deptName ?? ''))
  ).toList(),
  onChanged: (d) => setState(() => _selectedDepartment = d),
  labelText: l10n.department,
  validator: (v) => v == null ? l10n.requiredField : null,
)
```

### `DynamicDropdown`
Paginated + searchable dropdown for large datasets.

```dart
DynamicDropdown<Employe>(
  labelText: l10n.employee,
  fetchItems: (page, search) async =>
      await employeRepository.fetchEmployes(page, keyword: search),
  itemLabel: (e) => e.fullName,
  onSelected: (e) => setState(() => _selectedEmployee = e),
  initialValue: widget.item?.employe,
)
```

### `MultiSelectField`
Multi-select with chips.

```dart
MultiSelectField<String>(
  items: options,
  selectedItems: _selected,
  onChanged: (values) => setState(() => _selected = values),
  labelText: l10n.permissions,
)
```

---

## Date Picker

### `DatePickerField`
Date picker that outputs `DateTime?`.

```dart
DatePickerField(
  labelText: l10n.startDate,
  initialValue: _startDate,
  onChanged: (date) => setState(() => _startDate = date),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
)
```

Use `formatDateForApi(_startDate)` when sending to API.

---

## File Upload

### `AttachmentUploadWidget`
File picker integrated with `FileUploadBloc`.

```dart
AttachmentUploadWidget(
  onFileSelected: (bytes, fileName) {
    setState(() {
      _fileBytes = bytes;
      _fileName = fileName;
    });
  },
  allowedExtensions: ['pdf', 'jpg', 'png'],
)
```

---

## Feedback & Loading

### `LoadingWidget`
Centered circular progress indicator. Use when full list/page is loading.

```dart
const LoadingWidget()
```

### `EmptyWidget`
Placeholder when list is empty.

```dart
const EmptyWidget()
```

### `ModalProgressHUD`
Full-screen loading overlay inside dialogs.

```dart
ModalProgressHUD(
  inAsyncCall: state.flowStep == GenericFlowStep.creatingItem,
  child: AlertDialog(...),
)
```

### `DialogUtils.handleSuccess` / `DialogUtils.handleFailure`
Standard success/error feedback after CRUD operations.

```dart
await DialogUtils.handleSuccess(
  context,
  l10n.createSuccess,
  postActions: [
    () => bloc.add(const MyFeatureEvent.resetFlowStep()),
    () => bloc.add(const MyFeatureEvent.refreshMyFeatures()),
  ],
  shouldPopDialog: true,   // closes the calling dialog
);

await DialogUtils.handleFailure(
  context,
  state.myFeatureActionErrorMessage ?? l10n.operationError,
  postActions: [
    () => bloc.add(const MyFeatureEvent.resetFlowStep()),
  ],
  shouldPopDialog: false,  // keep dialog open so user can retry
);
```

---

## Layout Helpers

### `Gap`
Shorthand for `SizedBox(height: n)` or `SizedBox(width: n)`.

```dart
const Gap(12)    // vertical gap
Gap.horizontal(8)  // horizontal gap (check actual API)
```

### `ResponsiveLayout`
Layout breakpoint helper.

```dart
if (ResponsiveLayout.isMobile(context)) { ... }
if (ResponsiveLayout.isTablet(context)) { ... }
if (ResponsiveLayout.isDesktop(context)) { ... }
```

### `ResponsiveDialogWrapper`
Wraps a dialog content to adapt sizing for mobile vs desktop.

```dart
ResponsiveDialogWrapper(child: MyDialogContent())
```

---

## Extensions

### `context.localization`
```dart
// Instead of AppLocalizations.of(context)!
final l10n = context.localization;
```

### `context.theme`, `context.colorScheme`, `context.textTheme`
```dart
final color = context.colorScheme.primary;
final style = context.textTheme.bodyMedium;
```

---

## Global Colors

```dart
// From constant.dart — use everywhere
customColors.primary     // Green #16750C
customColors.secondary   // Teal #13708E
customColors.background  // Light grey #F5F5F5
customColors.surface     // White
customColors.error       // Red accent
customColors.success     // Green #2BD119
customColors.warning     // Amber #F9A912
customColors.cardBg      // Light blue #E2F4FA
```
