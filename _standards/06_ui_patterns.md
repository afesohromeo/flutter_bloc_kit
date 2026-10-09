# UI Patterns

> ⚠️ **Pagination**: the "List Page Pattern" / `AsyncPaginatedDataTable2` / `AsyncDataTableSource` sections below are the **web back-office** pattern (fixed-bottom datatable with an adjustable page size). It needs the `data_table_2` package, which the kit does not include by default. **The default for lists in kit apps is infinite scroll with `PagingController` / `CustomPaginatedList`:** follow [13_mobile_pagination.md](13_mobile_pagination.md). Everything else below (`ResponsiveScaffoldWrapper`, dialogs, UI rules) applies to all pages.

---

## ResponsiveScaffoldWrapper Pattern ⭐ **MANDATORY FOR ALL PAGES**

**Every page view in the application MUST be wrapped with `ResponsiveScaffoldWrapper`.** This is the core UI pattern that enables responsive designs across mobile, tablet, and desktop.

### Overview

`ResponsiveScaffoldWrapper` is a layout component that:
- Adapts the scaffold structure based on screen size (mobile, tablet, desktop)
- Integrates responsive drawer behavior (overlay on mobile/tablet, fixed sidebar on desktop)
- Provides consistent app bar, navigation, and content area management
- **Location:** `lib/src/shared/components/responsive_scaffold_wrapper.dart`

### Basic Structure

```dart
import 'package:my_app/my_app.dart';
import 'package:flutter/material.dart';

class MyFeaturePage extends StatelessWidget {
  const MyFeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        resizeToAvoidBottomInset: true,
        showBottomNav: false,
        showFloatingButton: false,
        hasAppbar: true,
        appBarBgColor: customColors.surface,
        showDrawer: true,
        leading: ResponsiveLayout.isDesktop(context) ? null : const CustomBackButton(),
        title: Text(
          l10n.myFeatureTitle,
          style: context.textTheme.displayMedium?.copyWith(
            fontSize: 16,
            color: customColors.black1,
          ),
        ),
        elevation: 0,
        actions: const [AppBarActions()],
      ),
      mobileBody: _buildContent(),
      tabletBody: _buildContent(),    // Optional: can be same as mobileBody
      desktopBody: _buildContent(),   // Optional: can be same as mobileBody
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        // Your page content here
      ],
    );
  }
}
```

### ScaffoldWrapperProps Configuration

| Property | Type | Default | Purpose |
|----------|------|---------|---------|
| `resizeToAvoidBottomInset` | `bool` | `true` | Resize scaffold when keyboard appears |
| `showBottomNav` | `bool` | `false` | Show bottom navigation bar |
| `showFloatingButton` | `bool` | `false` | Show floating action button |
| `hasAppbar` | `bool` | `true` | Show app bar |
| `appBarBgColor` | `Color` | `customColors.surface` | App bar background color |
| `showDrawer` | `bool?` | `true` | Show navigation drawer |
| `leading` | `Widget?` | `null` | Leading widget in app bar (menu/back button) |
| `title` | `Widget?` | `null` | App bar title |
| `actions` | `List<Widget>?` | `null` | Trailing actions in app bar |
| `elevation` | `double?` | `0` | App bar elevation |
| `bgColor` | `Color?` | `null` | Scaffold background color |
| `bottom` | `PreferredSizeWidget?` | `null` | Bottom widget (e.g., TabBar) |
| `buttonIcon` | `IconData?` | `null` | Floating button icon |
| `buttonColor` | `Color?` | `null` | Floating button color |
| `mini` | `bool?` | `null` | Floating button size |
| `onPressed` | `VoidCallback?` | `null` | Floating button callback |

### Common Patterns

#### 1. **Simple Page with Menu Button** (Most Common)

```dart
ResponsiveScaffoldWrapper(
  props: ScaffoldWrapperProps(
    resizeToAvoidBottomInset: true,
    showBottomNav: false,
    showFloatingButton: false,
    hasAppbar: true,
    appBarBgColor: customColors.surface,
    showDrawer: true,
    leading: ResponsiveLayout.isDesktop(context)
        ? null  // Hide menu on desktop (drawer is fixed)
        : Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: customColors.black1),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
    title: Text(l10n.myTitle),
    elevation: 0,
    actions: const [AppBarActions()],
  ),
  mobileBody: _buildBody(),
  tabletBody: _buildBody(),
  desktopBody: _buildBody(),
);
```

#### 2. **Shell Route with Back Button & Smart Menu** (For nested routes)

```dart
final location = GoRouterState.of(context).uri.path;
final isSubRoute = location.contains('/$detailPage');

ResponsiveScaffoldWrapper(
  props: ScaffoldWrapperProps(
    // ... common props
    leading: ResponsiveLayout.isDesktop(context) && !isSubRoute
        ? null  // Hide leading on desktop main route
        : Builder(
            builder: (ctx) => IconButton(
              icon: Icon(
                isSubRoute ? Icons.arrow_back_ios : Icons.menu,
                color: customColors.black1,
              ),
              onPressed: isSubRoute
                  ? () => context.pop()  // Back button for sub-route
                  : () => Scaffold.of(ctx).openDrawer(),  // Menu for main
            ),
          ),
    title: Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Text(_getTitle(location, l10n)),
    ),
  ),
  mobileBody: child,
  tabletBody: child,
  desktopBody: child,
);
```

#### 3. **Authentication Pages** (No Drawer)

```dart
ResponsiveScaffoldWrapper(
  props: ScaffoldWrapperProps(
    resizeToAvoidBottomInset: true,
    showBottomNav: false,
    showFloatingButton: false,
    hasAppbar: false,  // No app bar for login/signup
    showDrawer: false,  // No drawer
    elevation: 0,
  ),
  mobileBody: _buildLoginForm(context, l10n),
  tabletBody: _buildLoginForm(context, l10n),
  desktopBody: _buildLoginForm(context, l10n),
);
```

### Responsive Behavior

**Mobile (`< 600px`)**
- Drawer is **overlay** (slides in from left)
- Menu icon toggles drawer visibility
- Full-width content area

**Tablet (`600px - 1100px`)**
- Drawer is **overlay** (same as mobile)
- Menu icon toggles drawer visibility
- Full-width content area

**Desktop (`≥ 1100px`)**
- Drawer is **fixed sidebar** (280px width, always visible)
- No menu icon needed (drawer is persistent)
- Content area adjusted with padding

### Breakpoint Reference

Use `ResponsiveLayout` helper to check breakpoints:

```dart
if (ResponsiveLayout.isMobile(context)) { }      // < 600px
if (ResponsiveLayout.isTablet(context)) { }      // 600px - 1100px
if (ResponsiveLayout.isDesktop(context)) { }     // ≥ 1100px
```

---

## List Page Pattern

**Location:** `lib/src/features/{feature}/views/{feature}_page.dart`

```dart
class MyFeatureListPage extends StatefulWidget {
  const MyFeatureListPage({super.key});

  @override
  State<MyFeatureListPage> createState() => _MyFeatureListPageState();
}

class _MyFeatureListPageState extends State<MyFeatureListPage> {
  MyFeatureDataSource? _dataSource;
  Timer? _debounce;
  Key _tableKey = UniqueKey();
  String? _searchTerm;
  int _rowsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _initDataSource();
  }

  void _initDataSource() {
    _dataSource?.dispose();
    _dataSource = MyFeatureDataSource(
      bloc: context.read<MyFeatureBloc>(),
      context: context,
      searchTerm: _searchTerm,
    );
  }

  void _onRefresh() {
    setState(() {
      _tableKey = UniqueKey();
      _initDataSource();
    });
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      FocusManager.instance.primaryFocus?.unfocus();
      context.read<MyFeatureBloc>().add(const MyFeatureEvent.init());
      setState(() {
        _searchTerm = value.isEmpty ? null : value;
        _tableKey = UniqueKey();
        _initDataSource();
      });
    });
  }

  void _showCreateDialog() {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    showDialog(
      context: rootContext,
      builder: (_) => BlocProvider.value(
        value: context.read<MyFeatureBloc>(),
        child: CreateUpdateMyFeatureDialog(parentContext: rootContext),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listenWhen: (prev, curr) =>
          prev.refreshController != curr.refreshController,
      listener: (context, state) {
        if (state.refreshController) _onRefresh();
      },
      buildWhen: (prev, curr) =>
          prev.myFeatureStatus != curr.myFeatureStatus ||
          prev.myFeatures.length != curr.myFeatures.length,
      builder: (context, state) {
        final isLoading = state.myFeatureStatus == GenericStatus.loading ||
            state.myFeatureStatus == GenericStatus.filtering;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: SearchInputField(
                      onChanged: _onSearchChanged,
                      labelText: l10n.search,
                    ),
                  ),
                  PrimaryButton(
                    onPressed: _showCreateDialog,
                    child: Text(l10n.addNew),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const LoadingWidget()
                  : AsyncPaginatedDataTable2(
                      key: _tableKey,
                      source: _dataSource!,
                      rowsPerPage: _rowsPerPage,
                      onRowsPerPageChanged: (value) {
                        if (value != null) {
                          setState(() => _rowsPerPage = value);
                        }
                      },
                      columns: [
                        DataColumn2(label: Text(l10n.name)),
                        DataColumn2(label: Text(l10n.code)),
                        DataColumn2(label: Text(l10n.actions), fixedWidth: 120),
                      ],
                    ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _dataSource?.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
```

---

## DataSource Pattern

**Location:** `lib/src/features/{feature}/data_sources/{feature}_data_source.dart`

```dart
class MyFeatureDataSource extends AsyncDataTableSource {
  final MyFeatureBloc _bloc;
  final BuildContext context;
  final String? _searchTerm;

  StreamSubscription<MyFeatureState>? _subscription;
  String? _errorMessage;

  MyFeatureDataSource({
    required MyFeatureBloc bloc,
    required this.context,
    String? searchTerm,
  })  : _bloc = bloc,
        _searchTerm = searchTerm;

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    final completer = Completer<AsyncRowsResponse>();
    final pageKey = startIndex ~/ count;

    _subscription?.cancel();
    _subscription = _bloc.stream.listen((state) {
      if (state.myFeatureStatus == GenericStatus.success) {
        final rows = state.paginatedMyFeatures
            .map((item) => MyFeatureTile(data: item)
                .buildDataRow(context, onDelete: () => _onDelete(item)))
            .toList();
        if (!completer.isCompleted) {
          completer.complete(AsyncRowsResponse(state.totalCount, rows));
        }
        _subscription?.cancel();
      } else if (state.myFeatureStatus == GenericStatus.failure) {
        _errorMessage = state.myFeatureListErrorMessage ??
            LocalizationService.localization.errorLoadingMyFeatures;
        if (!completer.isCompleted) {
          completer.completeError(_errorMessage!);
        }
        _subscription?.cancel();
      }
    });

    _bloc.add(MyFeatureEvent.fetchMyFeatures(
      pageKey: pageKey,
      searchTerm: _searchTerm,
      size: count,
    ));

    return completer.future;
  }

  void _onDelete(MyFeature item) {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    showDialog(
      context: rootContext,
      builder: (_) => BlocProvider.value(
        value: _bloc,
        child: DeleteMyFeatureDialog(parentContext: rootContext, item: item),
      ),
    );
  }

  String? get errorMessage => _errorMessage;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
```

---

## Dialog Pattern

```dart
class CreateUpdateMyFeatureDialog extends StatefulWidget {
  const CreateUpdateMyFeatureDialog({
    super.key,
    required this.parentContext,
    this.item,       // null = create mode, non-null = update mode
  });

  final BuildContext parentContext;
  final MyFeature? item;

  @override
  State<CreateUpdateMyFeatureDialog> createState() =>
      _CreateUpdateMyFeatureDialogState();
}

class _CreateUpdateMyFeatureDialogState
    extends State<CreateUpdateMyFeatureDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _codeController;

  bool get _isUpdateMode => widget.item != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _codeController = TextEditingController(text: widget.item?.code ?? '');
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final newItem = MyFeature(
      id: widget.item?.id,
      name: _nameController.text.trim(),
      code: _codeController.text.trim(),
    );

    final bloc = context.read<MyFeatureBloc>();
    if (_isUpdateMode) {
      bloc.add(MyFeatureEvent.updateMyFeature(newItem));
    } else {
      bloc.add(MyFeatureEvent.createMyFeature(newItem));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(widget.parentContext)!;

    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listener: (context, state) async {
        final bloc = context.read<MyFeatureBloc>();

        if (state.myFeatureActionStatus == GenericStatus.success &&
            (state.flowStep == GenericFlowStep.creatingItem ||
                state.flowStep == GenericFlowStep.updatingItem)) {
          await DialogUtils.handleSuccess(
            context,
            _isUpdateMode ? l10n.updateSuccess : l10n.createSuccess,
            postActions: [
              () => bloc.add(const MyFeatureEvent.resetFlowStep()),
            ],
            shouldPopDialog: true,
          );
        }

        if (state.myFeatureActionStatus == GenericStatus.failure) {
          await DialogUtils.handleFailure(
            context,
            state.myFeatureActionErrorMessage ?? l10n.errorSavingMyFeature,
            postActions: [
              () => bloc.add(const MyFeatureEvent.resetFlowStep()),
            ],
            shouldPopDialog: false,   // Keep dialog open on failure
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.flowStep == GenericFlowStep.creatingItem ||
            state.flowStep == GenericFlowStep.updatingItem;

        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: AlertDialog(
            backgroundColor: customColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(_isUpdateMode ? l10n.edit : l10n.addNew),
            ),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(thickness: 2, height: 2),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: _nameController,
                          labelText: l10n.name,
                          validator: (v) =>
                              v == null || v.isEmpty ? l10n.requiredField : null,
                        ),
                        const Gap(12),
                        InputField(
                          controller: _codeController,
                          labelText: l10n.code,
                          validator: (v) =>
                              v == null || v.isEmpty ? l10n.requiredField : null,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 1.5, height: 1.5),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.cancel),
              ),
              PrimaryButton(
                onPressed: isLoading ? null : _onSubmit,
                child: Text(_isUpdateMode ? l10n.update : l10n.save),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}
```

---

## Delete Dialog Pattern

```dart
class DeleteMyFeatureDialog extends StatelessWidget {
  const DeleteMyFeatureDialog({
    super.key,
    required this.parentContext,
    required this.item,
  });

  final BuildContext parentContext;
  final MyFeature item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(parentContext)!;

    return BlocConsumer<MyFeatureBloc, MyFeatureState>(
      listener: (context, state) async {
        final bloc = context.read<MyFeatureBloc>();
        if (state.flowStep == GenericFlowStep.deletingItem &&
            state.myFeatureActionStatus == GenericStatus.success) {
          await DialogUtils.handleSuccess(
            context,
            l10n.deleteSuccess,
            postActions: [
              () => bloc.add(const MyFeatureEvent.resetFlowStep()),
              () => bloc.add(const MyFeatureEvent.refreshMyFeatures()),
            ],
            shouldPopDialog: true,
          );
        }
        if (state.myFeatureActionStatus == GenericStatus.failure) {
          await DialogUtils.handleFailure(
            context,
            state.myFeatureActionErrorMessage ?? l10n.errorDeletingMyFeature,
            postActions: [() => bloc.add(const MyFeatureEvent.resetFlowStep())],
            shouldPopDialog: true,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state.flowStep == GenericFlowStep.deletingItem,
          child: AlertDialog(
            backgroundColor: customColors.surface,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            title: Text(l10n.deleteConfirmTitle),
            content: Text(l10n.deleteConfirmMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(l10n.no),
              ),
              TextButton(
                onPressed: () => context
                    .read<MyFeatureBloc>()
                    .add(MyFeatureEvent.deleteMyFeature(item)),
                child: Text(l10n.yes,
                 style: context.textTheme.displayMedium
                ?.copyWith(color: customColors.error, fontSize: 14))
              ),
            ],
          ),
        );
      },
    );
  }
}
```

---

## Key UI Rules

### Colours and Text Styles
- Colours come from **`customColors`** (`core/my_app_colors.dart` + `shared/utils/constant.dart`). Never `Colors.xxx` or a hex value in a page or component, except `Colors.transparent`.
- Text styles come from **`context.textTheme.xxx?.copyWith(...)`**. Never a bare `TextStyle(...)`.

### User Feedback
- Success and error messages after an action use **`DialogUtils.handleSuccess` / `DialogUtils.handleFailure`** (dialogs). **Never `ScaffoldMessenger` / SnackBars.**
- Every error case has its **own** l10n key (12): the user sees what went wrong, not "An error occurred".

### Loading, Empty and Error States
| State | Widget |
|-------|--------|
| First load of a page or list | `ShimmerSkeleton` with `SkeletonBox` placeholders shaped like the content (or `LoadingWidget` for simple pages) |
| Action in a dialog | `ModalProgressHUD`, driven by `flowStep` (RULE-030) |
| Empty list | `EmptyWidget` |
| Failed load | `ErrorStateWidget` with a retry action |

### Forms
- Validators come from `Validators` (`shared/utils/validators.dart`), which return localized messages.
- Password fields: eye button whose icon shows the current state; visibility kept in the BLoC (02).
- Sign-up and password reset: a confirm-password field (`Validators.confirmPassword`).
- Email, password, name and similar fields set `autofillHints` so password managers work; group sign-in fields in an `AutofillGroup`.

### Context Safety
```dart
// ALWAYS capture root context before showDialog
final rootContext = Navigator.of(context, rootNavigator: true).context;
showDialog(context: rootContext, builder: (_) => ...);

// ALWAYS check mounted after async gaps
if (context.mounted) { ... }
```

### BlocConsumer Configuration
- `listenWhen`: compare only the fields the listener needs (minimize rebuilds)
- `buildWhen`: compare only fields used in the builder
- Use `prev.refreshController != curr.refreshController` to detect refresh triggers

### Dialog Styling
```dart
AlertDialog(
  backgroundColor: customColors.surface,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  contentPadding: EdgeInsets.zero,  // Always zero — use manual inner padding
  content: Column(children: [
    const Divider(thickness: 2, height: 2),  // Top divider: thickness 2
    Padding(padding: EdgeInsets.all(16), child: ...),
    const Divider(thickness: 1.5, height: 1.5),  // Bottom divider: thickness 1.5
  ]),
)
```

### DropdownButtonFormField
```dart
DropdownButtonFormField<MyModel>(
  isExpanded: true,   // ALWAYS — prevents overflow
  ...
)
```

### Search Debounce
```dart
Timer? _debounce;

void _onSearchChanged(String value) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 500), () {
    // search action
  });
}
```

### Table Refresh via UniqueKey
```dart
Key _tableKey = UniqueKey();

// To force full table rebuild:
setState(() {
  _tableKey = UniqueKey();
  _initDataSource();
});
```
