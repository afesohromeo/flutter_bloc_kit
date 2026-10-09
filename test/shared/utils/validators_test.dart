import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  late AppLocalizations l10n;

  setUpAll(() => l10n = setUpTestLocalization());

  group('Given Validators.required', () {
    test('when the value is empty or blank then it asks for a value', () {
      expect(Validators.required(null, l10n), l10n.validateRequired);
      expect(Validators.required('   ', l10n), l10n.validateRequired);
    });

    test('when the value has text then it is valid', () {
      expect(Validators.required('a', l10n), isNull);
    });
  });

  group('Given Validators.email', () {
    test('when the email is empty then it asks for one', () {
      expect(Validators.email('', l10n), l10n.validateEmailRequired);
      expect(Validators.email(null, l10n), l10n.validateEmailRequired);
    });

    test('when the email has no @ or no domain then it is invalid', () {
      expect(Validators.email('john', l10n), l10n.validateEmailInvalid);
      expect(Validators.email('john@', l10n), l10n.validateEmailInvalid);
      expect(Validators.email('john@mail', l10n), l10n.validateEmailInvalid);
    });

    test('when the email is well formed then it is valid, spaces trimmed', () {
      expect(Validators.email(' john@mail.com ', l10n), isNull);
    });
  });

  group('Given Validators.password', () {
    test('when the password is empty then it asks for one', () {
      expect(Validators.password('', l10n), l10n.validatePasswordRequired);
    });

    test(
      'when the password starts or ends with a space then it refuses it',
      () {
        expect(
          Validators.password(' secret123', l10n),
          l10n.validatePasswordSpaces,
        );
      },
    );

    test('when the password is too short then it gives the minimum length', () {
      expect(
        Validators.password('short', l10n),
        l10n.validatePasswordTooShort(Validators.minPasswordLength),
      );
    });

    test('when the password is long enough then it is valid', () {
      expect(Validators.password('long enough', l10n), isNull);
    });
  });

  group('Given Validators.confirmPassword', () {
    test('when the confirmation is empty then it asks for it', () {
      expect(
        Validators.confirmPassword('', 'secret123', l10n),
        l10n.validateConfirmPasswordRequired,
      );
    });

    test('when the confirmation differs then it reports the mismatch', () {
      expect(
        Validators.confirmPassword('secret124', 'secret123', l10n),
        l10n.validatePasswordMismatch,
      );
    });

    test('when the confirmation matches then it is valid', () {
      expect(
        Validators.confirmPassword('secret123', 'secret123', l10n),
        isNull,
      );
    });
  });

  group('Given Validators.fullName', () {
    test('when the name is blank then it asks for one', () {
      expect(Validators.fullName('  ', l10n), l10n.validateNameRequired);
    });

    test('when the name is too long then it gives the maximum length', () {
      final name = 'a' * (Validators.maxFullNameLength + 1);
      expect(
        Validators.fullName(name, l10n),
        l10n.validateNameTooLong(Validators.maxFullNameLength),
      );
    });

    test('when the name is filled in then it is valid', () {
      expect(Validators.fullName('Jane Doe', l10n), isNull);
    });
  });
}
