# Engineering Standards: Flutter BLoC Kit

This folder holds the **engineering standards** for every Flutter app created from this kit.
They started as a forensic analysis of a large production codebase (426+ Dart files, 93 features) and have been refined in every project since (PlusLocate, SmartDrive, Plotwatch).

> These documents are **binding context** for all development work.
> AI agents and developers MUST follow them when adding or modifying features.
> **Precedence:** these standards **>** generic guidance (agent skills, tutorials, "best practices").

---

## Index

| File | Contents |
|------|---------|
| [01_architecture.md](01_architecture.md) | Architecture, layer flow, project layout |
| [02_bloc_patterns.md](02_bloc_patterns.md) | BLoC events, states, handlers: canonical patterns |
| [03_folder_naming.md](03_folder_naming.md) | Folder structure per feature, naming, **barrel imports** |
| [04_api_repository.md](04_api_repository.md) | API provider, error handling, repository patterns |
| [05_models.md](05_models.md) | Model pattern (Freezed, fromJson, payload builders) |
| [06_ui_patterns.md](06_ui_patterns.md) | Pages, dialogs, feedback, forms, **ResponsiveScaffoldWrapper** |
| [07_routing.md](07_routing.md) | GoRouter, named and nested routes, auth guard, bottom-navigation shell |
| [08_shared_components.md](08_shared_components.md) | Shared widget and utility reference |
| [09_normalization_rules.md](09_normalization_rules.md) | All RULE-* enforcement rules (machine-readable) |
| [10_ai_agent_guide.md](10_ai_agent_guide.md) | Step-by-step guide for creating a feature |
| [11_inconsistencies.md](11_inconsistencies.md) | Known inconsistencies and refactoring backlog |
| [12_internationalization.md](12_internationalization.md) | **No hardcoded text**, ARB workflow, usage patterns ⭐ |
| [13_mobile_pagination.md](13_mobile_pagination.md) | **Infinite-scroll pagination (PagingController)**: the default for lists ⭐ |
| [14_serverpod.md](14_serverpod.md) | Using the kit with a **Serverpod** backend instead of a REST API |
| [15_testing.md](15_testing.md) | Test layout, helpers, BLoC/repository/widget tests |

---

## Quick Reference

- Architecture: **Clean Architecture + flutter_bloc + Freezed**
- State management: **BLoC** (never Riverpod, Provider-for-state, etc.; `provider` is only used for dependency injection)
- Models, events, states: **`@freezed` + `sealed class`** (Freezed 3+; `when`/`map` no longer exist, use `switch`)
- HTTP: **Dio** via `ApiProvider().dio` (REST apps) or the generated Serverpod client (see 14)
- Lists: **infinite scroll** with `PagingController` (13). `DataTable2` is for web back-office screens only.
- Routing: **GoRouter** with named routes, navigated with `context.goNamed(...)`
- Imports: **only through the package barrel** (`package:<app>/<app>.dart`)
- Localization: ⭐ **no hardcoded text anywhere**; one ARB key per error case
- Layout: **`ResponsiveScaffoldWrapper` for all pages** ⭐
- Colours and text: **`customColors`** and **`context.textTheme`**
- Feedback: **`DialogUtils.handleSuccess` / `handleFailure`**, never SnackBars
- Status enum: **`GenericStatus`** (initial / loading / filtering / success / failure)
- Flow tracking: **`GenericFlowStep`** (none / creatingItem / updatingItem / deletingItem)
- Tests: **`bloc_test` + `mocktail`**, helpers in `test/helpers/` (15)

---

## Maintaining these standards
- **Generic rules live here, in the kit.** A project copies this folder when it starts.
- **Project-specific additions** go into the project's copy as **new numbered files** (e.g. `16_offline_sync.md`), not as edits scattered through 01–15.
- **After each project**, copy generic improvements back into the kit.
