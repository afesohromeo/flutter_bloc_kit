# Agent Instructions

> **New project from the kit?** Replace this header with the app's name and one sentence about what it does, and point to its `doc/` folder. Keep the rest.

This is a Flutter app built from **flutter_bloc_kit** (layered architecture inspired by Clean Architecture, UI and BLoCs by feature; flutter_bloc + Freezed). See `_standards/01`.

---

## Engineering standards (binding)
All code follows [`_standards/`](_standards/README.md). Start with `README.md` and `10_ai_agent_guide.md`; check `09_normalization_rules.md` (RULE-001 to RULE-051) before proposing code.

**Precedence when guidance conflicts:** `_standards/` **>** project docs in `doc/` **>** agent skills **>** generic best practices. Project-specific additions are new numbered files in `_standards/` (e.g. `16_...md`); Serverpod apps also follow `14_serverpod.md`.

The kit's reference feature is `items` (`lib/src/features/items/` and its tests): copy its shape for new features.

---

## How to work
- **Plan first.** For every feature or fix: present the plan, wait for the developer's approval, save the approved plan in `doc/`, then implement step by step. Don't fast-track; don't treat proposals as decisions.
- **Test first (TDD).** Write the test, see it fail, then write the code (`_standards/15_testing.md`).
- **Code generation is run by the developer** (RULE-046): say "run `make codegen`" / "run `make i18n`" and wait.
- **Evidence before claims.** Run `make check` (format, analyze, test) and read the output before saying something works.
- **No hardcoded text**, one ARB key per error case; colours from `customColors`; imports through the app barrel.
- **UI follows the approved design.** When mockups were approved, screens match them (RULE-049): render new screens with the screenshot harness (`tool/screenshots/`, `_standards/15`) and compare before asking for review.
- **Long test runs:** when the developer asks, implement a batch of fixes with their tests and run the suites once at the end instead of after every change.
- **Checking the running app:** `flutter run --target lib/driver.dart` lets an agent drive the app through the Dart MCP server (`_standards/15`).
- **Before a release:** `_standards/16_release_checklist.md`.

---

## Commands
| Command | What it does |
|---------|--------------|
| `make codegen` | Freezed and asset code generation |
| `make i18n` | Localizations from `lib/src/core/l10n/*.arb` |
| `make check` | Format, analyze, test |
| `flutter test --update-goldens tool/screenshots/` | Screenshots of the screens (add `--dart-define=LOCALE=fr` for French) |
| `flutter run --dart-define=BASE_URL=https://api.example.com` | Run against an API (without it, the `items` demo uses local data) |

---

## Agent tooling
- **Skills** live in `.claude/skills/` and are installed locally, not committed: see [`.claude/SKILLS.md`](.claude/SKILLS.md). Before a task, check whether a skill applies, but apply the precedence rule above. Known conflicts:
  - `flutter-apply-architecture-best-practices` teaches MVVM/ViewModels → **overridden** by `_standards/01`, `02`.
  - `flutter-use-http-package` → not used: the app uses Dio through `ApiProvider` (`_standards/04`), or the Serverpod client (`14`).
  - `flutter-implement-json-serialization` → models use hand-written `fromJson` (`05`); Serverpod models are generated (`14`).
  - `brainstorming` / `writing-plans` save specs and plans in **`doc/`**.
- **MCP servers** (`dart`, `stitch`) are registered per project folder in the local Claude Code config; setup steps in `.claude/SKILLS.md`.
