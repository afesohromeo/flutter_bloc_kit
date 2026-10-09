# Flutter BLoC Kit

A starting point for Flutter apps: **Clean Architecture + flutter_bloc + Freezed**, with engineering standards, a working reference feature, tests and agent setup included.

**v2.0.0** · Flutter ≥ 3.44 · Dart ≥ 3.13 · Android, iOS (web/desktop: see below)

---

## What's inside

| Area | What you get |
|------|--------------|
| Architecture | UI → BLoC → Repository → API provider, one barrel import per app (`_standards/01`, `03`) |
| API layer | `ApiProvider` (Dio, base URL from `--dart-define`), interceptor (token, language, debug logs, 401 callback), typed exceptions, `AppApiResponse`, `PaginatedList<T>` |
| Reference feature | `items`: searchable infinite-scroll list with loading skeleton, empty and error states. Runs on demo data until you set `BASE_URL`. |
| Routing | GoRouter, named and nested routes, drawer, optional bottom-navigation shell |
| UI | `ResponsiveScaffoldWrapper` (mobile/tablet/desktop), form fields, dropdowns, pickers, dialogs, skeletons, `app_theme_kit` theme |
| Localization | English + French (ARB), no hardcoded text |
| Utilities | Validators, secure storage, connectivity check, debounced BLoC events, date/number formatting, file download |
| Errors | One `recordError` hook for all uncaught errors (plug in Crashlytics or Sentry) |
| Tests | `bloc_test` + `mocktail`, test helpers, 74 tests |
| Standards | `_standards/`: binding rules for developers and AI agents |
| Agent setup | `CLAUDE.md` template, `.claude/settings.json`, skills setup guide |

---

## Start a new app

1. **Create the repo** from this template on GitHub (*Use this template*), then clone it.
2. **Rename** the package, app name and bundle ID:
   ```bash
   dart pub global activate rename
   rename setAppName --targets android,ios --value "My App"
   rename setBundleId --targets android,ios --value "com.example.myapp"
   ```
   Then rename the Dart package: `name:` in `pubspec.yaml`, `lib/flutter_bloc_kit.dart` → `lib/my_app.dart`, and every `package:flutter_bloc_kit/` import.
3. **Brand:** replace the colours in `lib/src/shared/utils/constant.dart` and the splash/icon assets.
4. **Generate code:** `flutter pub get`, `make codegen`, `make i18n`.
5. **Run:** `flutter run` (demo data) or `flutter run --dart-define=BASE_URL=https://api.example.com`.
6. **Make it yours:** write `CLAUDE.md`'s header and a `doc/` folder for your specs. Replace the `items` feature with your first real feature, copying its shape.
7. **Agent tooling (optional):** install the skills and register the MCP servers as described in `.claude/SKILLS.md`.

**Serverpod backend?** Follow `_standards/14_serverpod.md`: Serverpod's standard layout, with this kit as the `*_flutter` package.

**Web or desktop?** The kit ships `android/` and `ios/`. Add others with `flutter create . --platforms web` (or `windows`, `macos`, `linux`).

---

## Commands

| Command | What it does |
|---------|--------------|
| `make codegen` | Freezed and asset code generation (`build_runner`) |
| `make i18n` | Localizations from `lib/src/core/l10n/*.arb` (`flutter gen-l10n`) |
| `make check` | Format, analyze, test: run before every commit |
| `make build-android` / `make build-ios` | Release builds |

Build-time configuration (`lib/src/core/environment.dart`):
```bash
flutter run --dart-define=env=prod --dart-define=BASE_URL=https://api.example.com
```

---

## Project layout

```
lib/
├── main.dart                 # runZonedGuarded → AppInitializer → Application
├── flutter_bloc_kit.dart     # root barrel: the only import app code uses
└── src/
    ├── core/                 # app, routing, layout, l10n, environment, colours
    ├── data/api/             # config/ (Dio, interceptor, errors) + one folder per API
    ├── domain/               # models/ (+ shared/) and repository/
    ├── features/             # home/, items/ (reference feature)
    └── shared/               # components/, extensions/, utils/
test/                         # mirrors lib/src/, helpers in test/helpers/
_standards/                   # engineering standards (start with README.md)
doc/                          # plans and specs
```

---

## Standards

The rules every change follows are in [`_standards/`](_standards/README.md): architecture, BLoC patterns, naming, API layer, models, UI, routing, i18n, pagination, Serverpod, testing, and the RULE-001 to RULE-046 checklist. When a project improves a generic rule, copy it back here.

See [`CHANGELOG.md`](CHANGELOG.md) for what changed in v2.
