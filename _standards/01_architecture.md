# Architecture

## Overview

Every app built from the kit uses a **layered architecture inspired by Clean Architecture**, with flutter_bloc and 4 layers (UI → BLoC → repository → API provider), and **UI and BLoCs organised by feature**.

### What kind of architecture this is (say it precisely)

Two separate questions, often confused:

| Question | Answer in the kit |
|----------|-------------------|
| **Which code may depend on which?** (Clean Architecture) | Dependencies point one way: UI → BLoC → repository → API provider. UI never calls a repository, BLoCs never call each other, API providers hold no logic. Every dependency is injected through constructors, so tests replace it with a mock. |
| **How are the folders arranged?** (feature-first vs layer-first) | **Hybrid**, as the Flutter team's architecture guide recommends: `features/{feature}/` holds that feature's BLoC and pages (feature-first); `data/` and `domain/` are shared layers (layer-first), because models and repositories serve several features. |

**Deliberate simplification:** strict Clean Architecture puts abstract repository interfaces in the domain and their implementations in the data layer (dependency inversion), so the domain depends on nothing. The kit's repositories are **concrete classes** that call the API providers directly: the domain layer depends on the data layer. This saves an interface per repository when there is only ever one implementation, and tests still mock the API provider through the repository's constructor. Add an interface when a repository really has two implementations (e.g. remote and offline).

In one sentence (README, CV, interviews): *"Layered architecture inspired by Clean Architecture: UI → BLoC → repository → data source, dependencies injected for testing, with UI and BLoCs organised by feature."*

---

## Layer Flow

```
UI Layer        (lib/src/features/{feature}/views/)
      |  add(Event)  ^  State updates
      v              |
BLoC Layer      (lib/src/features/{feature}/bloc/)
      |  call repo   ^  return model / throw
      v              |
Repository      (lib/src/domain/repository/)
      |  call API    ^  AppApiResponse
      v              |
API Provider    (lib/src/data/api/{feature}/)
                     ^  Dio HTTP (or the Serverpod client, see 14)
```

**Rules:**
- UI NEVER calls repositories directly
- Repositories NEVER call other repositories
- BLoCs NEVER call other BLoCs
- API providers NEVER contain business logic

Device APIs (camera, location, files, local database) get their own providers in `data/`, next to `api/` (e.g. `data/device/`, `data/local/`). Repositories call them exactly like API providers.

---

## Root Folder Structure

```
lib/
├── main.dart                    # runZonedGuarded + AppInitializer + runApp
├── {app}.dart                   # ROOT BARREL: the only import used by app code (see 03)
└── src/
    ├── core/                    # App bootstrap, routing, layout, theme colours, l10n
    │   ├── routing/             # RouteManager, route names, route paths
    │   ├── layout/              # ResponsiveLayout breakpoints
    │   ├── l10n/                # app_en.arb, app_fr.arb + generated AppLocalizations
    │   ├── application.dart     # Repository + BLoC providers
    │   ├── application_view.dart# MaterialApp.router, theme, locale
    │   ├── app_initializer.dart # Startup work + error reporting
    │   ├── environment.dart     # --dart-define values (env, base URL, keys)
    │   └── my_app_colors.dart   # App colour palette (customColors)
    │
    ├── data/                    # Outside world: HTTP, device, local storage
    │   └── api/
    │       ├── config/          # api_provider.dart, dio_interceptor.dart, api_error_handler.dart
    │       └── {feature}/       # {feature}_api_provider.dart
    │
    ├── domain/                  # Models + repositories
    │   ├── models/
    │   │   ├── shared/          # AppApiResponse, Pagination, PaginatedList
    │   │   └── {feature}.dart   # One file per domain model
    │   └── repository/
    │       └── {feature}_repository.dart
    │
    ├── features/                # Feature modules (BLoC + UI)
    │   └── {feature}/
    │
    └── shared/                  # Cross-feature code
        ├── components/          # Reusable widgets (08)
        ├── extensions/          # BuildContext, Iterable, GoRouter extensions
        └── utils/               # DialogUtils, validators, storage, constants, helpers
```

---

## Key Infrastructure Files

| File | Purpose |
|------|---------|
| `data/api/config/api_provider.dart` | Holds the single Dio instance (`ApiProvider().dio`), base URL and timeouts |
| `data/api/config/dio_interceptor.dart` | Attaches the auth token and locale; logs requests in debug builds; reports 401 |
| `data/api/config/api_error_handler.dart` | Converts `DioException` → typed exceptions |
| `domain/models/shared/app_api_response.dart` | Universal HTTP response wrapper |
| `shared/utils/constant.dart` | `customColors`, `formatDateForApi()`, `convertJsonDate()` |
| `shared/utils/dialog_utils.dart` | `DialogUtils.handleSuccess/handleFailure` |
| `shared/utils/localization_service.dart` | `LocalizationService.localization` for code without a `BuildContext` |
| `core/app_initializer.dart` | `preAppRun()`, `postAppRun()`, `recordError()` (crash reporting hook) |
| `core/routing/route_manager.dart` | GoRouter configuration (+ auth guard when the app has sign-in) |

---

## Exception Types

| Exception | When thrown |
|-----------|-------------|
| `HttpException400` | Any 4xx except 401/410: the server rejected the request (message from the server) |
| `HttpException401` | 401: not signed in or session expired |
| `HttpException410` | 410: resource or account permanently gone (when the backend uses it) |
| `NetworkException` | No connection, timeout, 5xx |

BLoC handlers MUST catch the typed exceptions they care about (at least `HttpException400`) before the generic `catch (e)`.

---

## Startup and Errors

`main.dart` runs the app inside `runZonedGuarded`. Uncaught errors (zone, `FlutterError.onError`, `PlatformDispatcher.onError`) all go to `AppInitializer.recordError()`. In debug builds it prints the stack; in a real app, plug Crashlytics or Sentry in there (one place).
