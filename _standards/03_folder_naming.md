# Folder Structure & Naming Conventions

## Per-Feature Folder Structure

Every feature follows this exact layout:

```
features/{feature_name}/
├── {feature}.dart                    (feature barrel: exports bloc + views)
├── bloc/
│   ├── {feature}_bloc.dart
│   ├── {feature}_event.dart
│   ├── {feature}_state.dart
│   └── {feature}_bloc.freezed.dart   (generated)
└── views/
    ├── {feature}_page.dart           (main list/detail page)
    └── widgets/
        ├── {feature}_card.dart       (list item for infinite-scroll lists)
        ├── create_update_{feature}_dialog.dart
        └── delete_{feature}_dialog.dart
```

Web back-office screens using `DataTable2` (06) also have `views/widgets/{feature}_tile.dart` (DataRow builder) and `data_sources/{feature}_data_source.dart` (`AsyncDataTableSource`).

Shared data layers (one per domain group, not per feature):

```
data/api/{domain}/
└── {feature}_api_provider.dart

domain/
├── models/
│   └── {feature}.dart                (Freezed model)
└── repository/
    └── {feature}_repository.dart
```

---

## Barrel Files and Imports ⭐

App code imports **only the package's root barrel**:

```dart
import 'package:my_app/my_app.dart';   // CORRECT — the only app import

import 'package:my_app/src/shared/components/gap.dart';   // WRONG — deep import
import '../../shared/components/gap.dart';                // WRONG — relative import
```

- `lib/{app}.dart` exports one barrel per layer: `src/core/core.dart`, `src/data/data.dart`, `src/domain/domain.dart`, `src/features/features.dart`, `src/shared/shared.dart` (plus `app_theme_kit`).
- Each layer barrel exports its sub-barrels (`shared/components/components.dart`, `domain/models/models.dart`, …); each feature has its own barrel (`features/{feature}/{feature}.dart`).
- **Every new file is added to its folder's barrel in the same change.** A file missing from its barrel is a review finding.
- Third-party packages are imported directly (`package:flutter_bloc/flutter_bloc.dart`, `package:go_router/go_router.dart`).
- Tests import the app barrel plus `test/helpers/helpers.dart` (15).
- `part` files (`*_event.dart`, `*_state.dart`, `*.freezed.dart`) are never exported: their library file is.

---

## File Naming Rules

All files use **snake_case**.

| Suffix | Layer | Example |
|--------|-------|---------|
| `_bloc.dart` | BLoC | `absence_bloc.dart` |
| `_event.dart` | BLoC | `absence_event.dart` |
| `_state.dart` | BLoC | `absence_state.dart` |
| `_repository.dart` | Domain | `absence_repository.dart` |
| `_api_provider.dart` | Data | `absence_api_provider.dart` |
| `_page.dart` | UI | `absence_list_page.dart` |
| `_dialog.dart` | UI | `create_update_absence_dialog.dart` |
| `_card.dart` | UI | `absence_card.dart` (infinite-scroll list item) |
| `_tile.dart` | UI | `absence_tile.dart` (DataTable2 row) |
| `_data_source.dart` | UI | `absence_data_source.dart` |
| `_extensions.dart` | Shared | `context_extensions.dart` |
| `_utils.dart` | Shared | `dialog_utils.dart` |
| `_constants.dart` | Shared | `app_constants.dart` |

---

## Class Naming Rules

All classes use **PascalCase**.

| Pattern | Example |
|---------|---------|
| `{Feature}Bloc` | `AbsenceBloc`, `DepartmentBloc` |
| `{Feature}Event` | `AbsenceEvent`, `DepartmentEvent` |
| `{Feature}State` | `AbsenceState`, `DepartmentState` |
| `{Feature}Repository` | `AbsenceRepository`, `DepartmentRepository` |
| `{Feature}ApiProvider` | `AbsenceApiProvider`, `DepartmentApiProvider` |
| `{Feature}Page` | `AbsenceListPage`, `DepartmentListPage` |
| `{Feature}Dialog` | `CreateUpdateAbsenceDialog`, `DeleteDepartmentDialog` |
| `{Feature}Tile` | `AbsenceTile`, `DepartmentTile` |
| `{Feature}DataSource` | `AbsenceDataSource`, `DepartmentDataSource` |
| Model name | `Absence`, `Department`, `Employe` (no suffix) |

---

## Event Factory Method Naming

| Method | Purpose |
|--------|---------|
| `.init()` | Initialize / load initial data |
| `.fetch{Items}(...)` | Fetch/paginate list |
| `.refresh{Items}()` | Trigger refresh of existing list |
| `.select{Item}(item)` | Set selected item for detail view |
| `.create{Item}(item)` | Create new record |
| `.update{Item}(item)` | Update existing record |
| `.delete{Item}(item)` | Delete record |
| `.resetFlowStep()` | Clear flowStep + action status |
| `.reset()` | Reset full state to initial |

---

## BLoC Handler Naming

```
_on{EventName}(_PrivateEventType event, Emitter<State> emit)
```

Examples:
```dart
_onInit(_Init event, Emitter<AbsenceState> emit)
_onFetchAbsences(_FetchAbsences event, Emitter<AbsenceState> emit)
_onCreateAbsence(_CreateAbsence event, Emitter<AbsenceState> emit)
_onDeleteAbsence(_DeleteAbsence event, Emitter<AbsenceState> emit)
_onResetFlowStep(_ResetFlowStep event, Emitter<AbsenceState> emit)
_onReset(_Reset event, Emitter<AbsenceState> emit)
```

---

## State Field Naming

Status fields are **feature-scoped** — never generic:

```dart
// CORRECT — scoped to operation
GenericStatus absenceStatus           // list fetching
GenericStatus absenceDetailStatus     // single item detail
GenericStatus absenceActionStatus     // create/update/delete

// WRONG — too generic
GenericStatus status
GenericStatus loadingStatus
```

Error message fields mirror status fields:

```dart
String? absenceListErrorMessage
String? absenceDetailErrorMessage
String? absenceActionErrorMessage
```

List fields:
```dart
List<Absence> absences           // Full accumulated list (infinite scroll)
List<Absence> paginatedAbsences  // Current page only (fed to DataSource)
```
