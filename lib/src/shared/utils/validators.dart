import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Form validators. Each returns a localized message, or `null` when the
/// value is valid:
///
/// ```dart
/// validator: (value) => Validators.email(value, l10n),
/// ```
///
/// Add app-specific rules here (one ARB key per failure), never inline in a
/// page.
class Validators {
  Validators._();

  static const minPasswordLength = 8;
  static const maxFullNameLength = 100;

  static final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? required(String? value, AppLocalizations l10n) {
    if ((value?.trim() ?? '').isEmpty) return l10n.validateRequired;
    return null;
  }

  static String? email(String? value, AppLocalizations l10n) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return l10n.validateEmailRequired;
    if (!_email.hasMatch(email)) return l10n.validateEmailInvalid;
    return null;
  }

  static String? password(String? value, AppLocalizations l10n) {
    final password = value ?? '';
    if (password.isEmpty) return l10n.validatePasswordRequired;
    if (password.trim() != password) return l10n.validatePasswordSpaces;
    if (password.length < minPasswordLength) {
      return l10n.validatePasswordTooShort(minPasswordLength);
    }
    return null;
  }

  static String? confirmPassword(
    String? value,
    String password,
    AppLocalizations l10n,
  ) {
    final confirmation = value ?? '';
    if (confirmation.isEmpty) return l10n.validateConfirmPasswordRequired;
    if (confirmation != password) return l10n.validatePasswordMismatch;
    return null;
  }

  static String? fullName(String? value, AppLocalizations l10n) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return l10n.validateNameRequired;
    if (name.length > maxFullNameLength) {
      return l10n.validateNameTooLong(maxFullNameLength);
    }
    return null;
  }
}
