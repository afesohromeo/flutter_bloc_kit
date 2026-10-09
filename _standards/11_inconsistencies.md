# Inconsistencies & Refactoring Backlog

Derived from forensic analysis of the codebase.
Items are grouped by impact. Do not fix these opportunistically during unrelated tasks.

---

## High Impact

### H-001 — Hardcoded credentials in `constant.dart`
**File:** `lib/src/shared/utils/constant.dart`

`fakeToken`, `fakeBioTimeToken`, and `baseUrl` with a hardcoded IP address
(`192.168.1.127`) are committed in source code.

**Risk:** Credential leakage, broken builds when server IP changes.
**Fix:** Move to a `.env` file or Flutter `--dart-define` build args.
Load via a config service at startup.

---

### H-002 — `AppApiResponse.data2` is untyped (`dynamic`)
**File:** `lib/src/domain/models/shared models/app_api_response.dart`

All create/update endpoints cast `data2` at the call site:
```dart
MyModel.fromJson(apiResponse.data2 as Map<String, dynamic>)
```
This is an unsafe cast that will throw at runtime if the API changes shape.

**Risk:** Runtime type errors with no compile-time warning.
**Fix:** Either make `data2` generic (`AppApiResponse<T>`) or add a safe helper:
```dart
Map<String, dynamic>? get data2AsMap =>
    data2 is Map<String, dynamic> ? data2 as Map<String, dynamic> : null;
```

---

## Medium Impact

### M-001 — Folder names with spaces
**Folders:**
- `lib/src/features/gestion des absences/`
- `lib/src/features/gestion des ouvriers/`
- `lib/src/domain/models/shared models/`

Spaces in folder names cause issues with some CI runners, shell scripts, and tooling.

**Fix:** Rename to snake_case:
- `gestion_des_absences/`
- `gestion_des_ouvriers/`
- `shared_models/`

Update all imports accordingly.

---

### M-002 — `LoginStatus` vs `GenericStatus` split
**File:** `lib/src/features/authentication/bloc/`

The authentication BLoC uses a custom `LoginStatus` enum with different case names
(`inProgress`, `sucess`, `forceLogin`, `selectSite`, `loadingSites`) instead of the
project-standard `GenericStatus`.

**Impact:** AI agents and new developers must learn two status systems.
**Fix:** Migrate `LoginStatus` to use `GenericStatus` where applicable.
Keep auth-specific cases (`forceLogin`, `selectSite`) in a separate `AuthFlowStep` enum,
mirroring the `GenericFlowStep` pattern.

---

### M-003 — Typo: `sucess` in `LoginStatus` enum
**File:** `lib/src/features/authentication/bloc/authentication_state.dart` (or similar)

```dart
// Actual code
sucess,   // should be: success
```

**Risk:** Any new code matching on this case will introduce a silent mismatch.
**Fix:** Rename with find-replace across all files referencing `LoginStatus.sucess`.

---

### M-004 — No abstract interfaces for repositories
All repositories are concrete classes. There are no abstract base classes or interfaces.

**Impact:** Cannot mock repositories in unit tests without a mocking library that
patches concrete classes.
**Fix (optional):** Add abstract interfaces:
```dart
abstract class IAbsenceRepository {
  Future<PaginatedList?> fetchAbsences(int pageKey, {...});
  Future<Absence?> createAbsence(Map<String, dynamic> data);
}
class AbsenceRepository implements IAbsenceRepository { ... }
```
BLoC constructors would then accept `IAbsenceRepository` — enabling test mocks.

---

## Low Impact

### L-001 — Typo: `errorr_widget.dart` (double r)
**File:** `lib/src/shared/components/errorr_widget.dart`

The file has a double `r` in its name. The class inside likely matches.

**Fix:** Rename file and class, update all import references.

---

### L-002 — Mixed `_page.dart` / `_view.dart` suffixes
Some feature screens use `_view.dart` instead of the dominant `_page.dart` suffix.

**Fix:** Standardize all screen files to `_page.dart`.

---

### L-003 — `ScafoldWrapper` / `ResponsiveScafoldWrapper` typo
**Files:** `shared/components/scafold_wrapper.dart`, `responsive_scafold_wrapper.dart`

Both files and their classes have a missing `f` in `Scaffold`.

**Fix:** Rename files and classes, update all references.

---

## Do Not Fix Without Planning

The following are noted but require coordinated effort due to widespread references:

- **Folder renames with spaces (M-001):** Requires updating every import in 93 feature directories.
- **`data2` typing (H-002):** Requires changing the `AppApiResponse` model and updating every
  repository that calls `data2 as Map<String, dynamic>` — 10+ files.
- **Repository interfaces (M-004):** Requires creating 16 interface files and updating 25 BLoC
  constructors. Only worthwhile if unit testing is being set up.
