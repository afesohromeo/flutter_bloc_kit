# Kit refresh plan (v2)

> **Status:** Approved 2026-10-08
> **Branch:** `refresh/v2` (local commits per phase; pushed only after the developer's review)
> **Goal:** make this kit the single source of truth for new Flutter projects: app skeleton + engineering standards + agent setup. Bring in the improvements made since April 2026 in PlusLocate, SmartDrive and Plotwatch.

---

## 1. Why
- Three copies drifted apart: the kit (last change 2026-04-22), the private `flutter_standards` repo (also April), and each project's modified copy of `_standards/`, `.claude/` and kit code. Improvements never flowed back.
- The standards describe an API layer (`ApiProvider`, `ApiErrorHandler`, `AppApiResponse`, `PaginatedList`) that the kit doesn't contain.
- `SENIOR_REVIEW.md` (April 2026) lists dead code, an always-`true` connectivity check, commented-out validators, an empty test folder and an empty error handler.
- A real JWT (`fakeToken`) was committed in `shared/utils/constant.dart`. The developer confirmed it no longer works; it's removed in this refresh.

## 2. Decisions
| # | Decision |
|---|----------|
| K-1 | The kit holds `_standards/` (generic) and `.claude/` (CLAUDE.md template + `settings.json` + `SKILLS.md` with install sources). Third-party skills are **not** committed (no licence files, public repo). The private `flutter_standards` repo is archived afterwards. |
| K-2 | Project-specific additions live in each project as new numbered files (e.g. `14_serverpod_adaptation.md`), not as edits scattered through the generic files. After each project, generic improvements are copied back into the kit. |
| K-3 | `fakeToken` removed from the kit (and from PlusLocate's working tree). No history rewrite: the token no longer works. |
| K-4 | The kit ships a small **reference feature** (API → repository → BLoC → infinite-scroll page, with tests) that `10_ai_agent_guide.md` points agents to. |
| K-5 | Typos fixed for new projects only: `ErrorrWidget` → **`ErrorStateWidget`** (`error_state_widget.dart`). The name `ErrorWidget` is taken by Flutter's own class (`flutter/widgets/framework.dart`), which the kit uses in `AppInitializer`; `error` itself is not a reserved word. File names `scafold_*` → `scaffold_*` (class names were already correct). |
| K-6 | Existing projects (PlusLocate, SmartDrive, Plotwatch) are not modified by this refresh, except removing the token from PlusLocate. |

## 3. Phases

### Phase 1: standards (`_standards/`)
- Start from the latest copy (PlusLocate = SmartDrive) and remove project-specific text ("Extension Sage Paie", SmartDrive, `VoyageBloc`).
- Write down conventions enforced in reviews: imports through barrels only; `context.goNamed`; `customColors` + `context.textTheme`; one l10n key per error case; errors through `DialogUtils` (no SnackBars); password visibility state in the BLoC; confirm-password field; nested routes so Back goes up a level; Freezed classes `sealed`; `return await` inside `try`; the developer runs code generation; test helper conventions.
- Add a generic "kit + Serverpod" guide from Plotwatch's `14_serverpod_adaptation.md`.
- Update `11_inconsistencies.md` (fixed items) and resolve the i18n tooling mismatch (Makefile uses `intl_utils`; the kit is configured for `flutter gen-l10n`).

### Phase 2: code
| Area | Change | Source |
|------|--------|--------|
| Dependencies | Freezed 4 (classes `sealed`), freezed_annotation 3, flutter_secure_storage 10, `bloc_test` + `mocktail`; remove unused packages | All projects |
| API layer | `ApiProvider` (one Dio client, base URL from `--dart-define`), interceptor (auth header, locale, debug-only logging), `ApiErrorHandler` + typed exceptions, `AppApiResponse` / `Pagination` / `PaginatedList` | SmartDrive, generalized |
| Utilities | Real connectivity check (web-safe), validators (static, localized), `debounceSequential` event transformer, environment helpers, secure storage with `resetOnError` | SmartDrive, Plotwatch, PlusLocate |
| Crash reporting | Error-reporting hook in `AppInitializer` (logs in debug; one place to plug in Crashlytics/Sentry); no Firebase dependency | PlusLocate |
| Components | `ShimmerSkeleton` + `SkeletonBox`, `MeasureSize`, `SearchInputField` (focus node, editing complete, tappable suffix), `InputField.autofillHints`, dropdown theme-colour fixes, `return await` in `DialogHelper`, optional bottom-navigation shell (`StatefulShellRoute`) next to the drawer | PlusLocate, Plotwatch |
| Cleanup | Remove token, commented-out code, counter demo; K-5 renames; format with the current Dart formatter; analyzer excludes for build and platform folders | Senior review, projects |
| Reference feature | K-4 | New |
| Tests | `test/helpers` (`pumpApp`, mocks, localization) + tests for everything added (TDD) | Plotwatch |

### Phase 3: agent setup and docs
- `.claude/` per K-1; root `CLAUDE.md` template pointing to `_standards/`.
- README rewritten (setup, rename, environments, codegen, i18n, Serverpod note), Makefile fixed, `CHANGELOG.md`, tag `v2.0.0` after review.

## 4. Out of scope (follow-ups)
- `app_theme_kit` (separate package): body text coloured with the secondary colour, font downloaded at runtime (found in Plotwatch); the local repo has one unpushed commit.
- Rewriting Git history for the token.

## 5. Definition of done
- `flutter analyze` clean; `flutter test` green; the app runs on Android and web.
- Every RULE-* in `_standards/09_normalization_rules.md` holds in the kit's own code.
- The developer reviews the branch before anything is pushed.
