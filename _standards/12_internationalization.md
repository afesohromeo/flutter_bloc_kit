# Internationalization (i18n) — NO HARDCODED TEXT RULE ⭐

## Golden Rule

**ZERO hardcoded strings allowed anywhere in the codebase.**

✗ **FORBIDDEN:**
```dart
// Page
Text("Dashboard")  // Hardcoded — WRONG

// BLoC
throw Exception("Operation failed");  // Hardcoded — WRONG

// Repository
print("User created");  // Hardcoded — WRONG
```

✓ **REQUIRED:**
```dart
// Page
Text(l10n.dashboard)  // From localization — CORRECT

// BLoC
throw Exception(LocalizationService.localization.operationFailed);  // CORRECT

// Repository
log(LocalizationService.localization.userCreated);  // CORRECT
```

---

## System Overview

**Files:** `lib/src/core/l10n/app_en.arb` (English) & `app_fr.arb` (French)  
**Generated:** `lib/src/core/l10n/app_localizations.dart` (auto-generated, do NOT edit)  
**Configuration:** `l10n.yaml` at project root  
**Generator:** Flutter's built-in `gen-l10n` (`flutter: generate: true` in `pubspec.yaml`), run with `flutter gen-l10n` or `make i18n`. It also runs automatically on `flutter pub get` / `flutter run`.

---

## Workflow: Adding a New String

### Step 1: Add to English ARB File

**File:** `lib/src/core/l10n/app_en.arb`

```json
{
    "@@locale": "en",
    "existingKey": "Existing value",
    
    "myNewKey": "My new feature text",
    "@myNewKey": {
        "description": "Brief description of where/why this string is used"
    }
}
```

**Key Naming Convention:**
- Use **camelCase**: `myNewKey`, `operationSuccess`, `errorLoadingData`
- Start with lowercase
- Prefix semantic keys: `error*`, `validate*`, `label*`, `msg*`, etc.
- **One key per error case** (`errorLoadingItems`, `errorDeletingItem`, `errorInvitationExpired`). Don't reuse a generic `operationError`: the user must see what went wrong.

### Step 2: Add to French ARB File

**File:** `lib/src/core/l10n/app_fr.arb`

```json
{
    "@@locale": "fr",
    "existingKey": "Valeur existante",
    
    "myNewKey": "Mon texte de nouvelle fonctionnalité",
}
```

⚠️ **Important:** French file does NOT include `@key` metadata objects (only English does).

### Step 3: Generate Localizations

```bash
# Option 1: Via Makefile
make i18n

# Option 2: Direct command
flutter gen-l10n
```

This generates `lib/src/core/l10n/app_localizations.dart` with all localization getters.

### Step 4: Use in Code

See [Usage Patterns](#usage-patterns) below.

---

## Usage Patterns

### Pattern 1: In Widgets (WITH Context)

Use `AppLocalizations.of(context)!` to get localization instance.

```dart
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;  // ← Get instance ONCE

    return Column(
      children: [
        Text(l10n.dashboard),  // ← Use like a property
        Text(l10n.welcome),
        Icon(...),
      ],
    );
  }
}
```

**Best practice:** Capture `l10n` once at the top of your `build()` method, then reuse it.

### Pattern 2: In BLoCs & Repositories/services (NO Context)

Use `LocalizationService.localization` — works anywhere without `BuildContext`.

```dart
class MyFeatureBloc extends Bloc<MyFeatureEvent, MyFeatureState> {
  MyFeatureBloc() : super(const MyFeatureState.initial()) {
    on<MyFeatureEvent>((event, emit) async {
      try {
        // ... operation
      } catch (e) {
        // ❌ WRONG: NEVER hardcode
        throw Exception("Operation failed");
        
        // ✓ CORRECT: Use localization
        throw Exception(LocalizationService.localization.operationFailed);
      }
    });
  }
}
```

**Repository Example:**

```dart
class MyFeatureRepository {
  Future<List<MyFeature>> fetchMyFeatures() async {
    try {
      final response = await _dio.get('/features');
      return (response.data as List).map((e) => MyFeature.fromJson(e)).toList();
    } on DioException catch (e) {
      log(LocalizationService.localization.networkError);
      throw Exception(LocalizationService.localization.networkError);
    }
  }
}
```

### Pattern 3: Error Messages

**In Repository/BLoC (error messages thrown):**
```dart
throw Exception(LocalizationService.localization.errorSavingData);
```

**In Widget (error messages shown):** through `DialogUtils`, never a SnackBar (06):
```dart
await DialogUtils.handleFailure(
  context,
  state.myFeatureActionErrorMessage ?? l10n.errorSavingData,
  postActions: [() => bloc.add(const MyFeatureEvent.resetFlowStep())],
);
```

### Pattern 4: Validation Messages

Validators live in `shared/utils/validators.dart` as static methods that take the `AppLocalizations` and return a localized message (or `null` when valid):
```dart
InputField(
  labelText: l10n.labelEmail,
  keyboardType: TextInputType.emailAddress,
  autofillHints: const [AutofillHints.email],
  validator: (value) => Validators.email(value, l10n),
)
```
Add new rules to `Validators` (one ARB key per failure: `validateEmailRequired`, `validateEmailInvalid`, …), never inline in a page.

### Pattern 5: Custom Dialog Messages

```dart
void _showSuccessDialog(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.success),
      content: Text(l10n.operationCompletedSuccessfully),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: Text(l10n.ok),  // "OK" / "OK"
        ),
      ],
    ),
  );
}
```

---

## Common Localization Keys

Pre-existing keys you can use (already defined in ARB files):

### UI Controls
- `ok` — "Ok" / "OK"
- `cancel` — "Cancel" / "Annuler"
- `yes` — "Yes" / "Oui"
- `no` — "No" / "Non"
- `confirm` — "Confirm" / "Confirmer"
- `close` — "Close" / "Fermer"
- `save` — "Save" / "Enregistrer"

### Form Fields
- `username` — Username label
- `password` — Password label
- `emailAddress` — Email Address label
- `phoneNumber` — Phone Number label
- `firstName` — First Name
- `lastName` — Last Name
- `required` — "Field required" / "Champ requis"

### Status & Feedback
- `success` — Success message prefix
- `error` — Error message prefix
- `loading` — Loading indicator text

### Pages/Sections
- `dashboard` — Dashboard page title
- `profile` — Profile page title
- `login` — Login page title
- `logout` — Logout action
- `search` — Search placeholder

---

## File Locations & Configuration

### ARB Files

**Location:** `lib/src/core/l10n/`

```
lib/src/core/l10n/
├── app_en.arb          ← English strings + metadata
├── app_fr.arb          ← French strings (no metadata)
└── app_localizations.dart  ← AUTO-GENERATED (do not edit)
```

### Configuration

**File:** `l10n.yaml` (project root)

```yaml
arb-dir: lib/src/core/l10n
template-arb-file: app_en.arb    # English is the source/template
output-localization-file: app_localizations.dart
untranslated-messages-file: toFrench.txt  # For missing French translations
```

---

## Best Practices

### ✓ DO

- **Define every user-facing string in ARB files** before using it
- **Use semantic key names:** `errorLoadingUser`, `labelEmailAddress`, `buttonSubmit`
- **Add clear descriptions** in the `@key` metadata for context
- **Run `make i18n` after every ARB edit** (or `flutter gen-l10n`)
- **Use small, focused localization keys** for reusability
- **Capture `l10n` once per build()** method in widgets to avoid repeated lookups

### ✗ DON'T

- **NEVER hardcode user-facing strings** — even for testing
- **NEVER skip the generation step** after adding strings
- **NEVER use string concatenation for compound messages** — create separate keys instead
- **NEVER add metadata to `app_fr.arb`** — only `app_en.arb` has `@key` objects
- **NEVER call `AppLocalizations.of(context)` in code outside of `build()` in repositories/blocs** — use `LocalizationService.localization` instead

### Example: Compound Messages (✓ DO THIS)

Instead of:
```dart
// ❌ WRONG: Hardcoded concatenation
Text("User " + userName + " created successfully")

// ❌ ALSO WRONG: Hardcoded with variable
Text("User $userName created successfully")
```

Do this:

**ARB files:**
```json
// app_en.arb
"userCreatedMessage": "User {name} created successfully",
"@userCreatedMessage": {
    "description": "Message shown when user is created",
    "placeholders": {
        "name": {
            "type": "String",
            "example": "John Doe"
        }
    }
}
```

**Usage:**
```dart
Text(l10n.userCreatedMessage(userName))
```

---

## Debugging & Troubleshooting

### ❌ String not appearing after `make i18n`?

1. **Check the ARB file syntax** — must be valid JSON
2. **Ensure `@@locale` is present** in both files
3. **Run `flutter clean` then `make i18n` again**
4. **Rebuild app** — generated files may not hot-reload

### ❌ "Method not found" error?

- The localization string wasn't generated yet
- **Solution:** Run `make i18n` and rebuild

### ❌ French translation missing?

- Check `toFrench.txt` file — lists untranslated strings
- Add the missing key to `app_fr.arb`
- Run `make i18n` again

---

## Enforcement

**Code Review Check:**
- ✓ All user-facing strings use `l10n.*` or `LocalizationService.localization.*`?
- ✓ ARB files updated with translations?
- ✓ `make i18n` was run?
- ✓ Generated code committed?

**Linting:**
Consider setting up a linter rule to detect hardcoded strings in UI files (optional).

---

## See Also

- [CLAUDE.md](../CLAUDE.md#regenerate-i18n) — Makefile i18n command
- [09_normalization_rules.md](09_normalization_rules.md#localization) — Related localization rule
- `lib/src/core/l10n/app_localizations.dart` — Generated getter reference
