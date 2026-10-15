import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

// Amounts are integers in the currency's minor units, typed and shown in the
// app language.
void main() {
  setUpAll(() => initializeDateFormatting());

  // French groups digits with a narrow no-break space (U+202F).
  const nnbsp = ' ';

  group('Given a currency', () {
    test('then XAF has no minor units and EUR and USD have two', () {
      expect(currencyDigits('XAF'), 0);
      expect(currencyDigits('EUR'), 2);
      expect(currencyDigits('USD'), 2);
    });
  });

  group('Given an amount in minor units when it is shown', () {
    // "1,500,000 FCFA", as written in Cameroon.
    test('in XAF then it is grouped with commas, FCFA after, in every '
        'language', () {
      expect(formatMoney(1500000, 'XAF', locale: 'en'), '1,500,000 FCFA');
      expect(formatMoney(1500000, 'XAF', locale: 'fr'), '1,500,000 FCFA');
    });

    test('in short then FCFA follows the figure', () {
      expect(formatMoneyShort(12500000, 'XAF', locale: 'fr'), '12.5 M FCFA');
    });

    test('in EUR then the cents are shown', () {
      expect(formatMoney(125050, 'EUR', locale: 'en'), '€1,250.50');
      expect(formatMoney(125050, 'EUR', locale: 'fr'), '1${nnbsp}250,50 €');
    });

    test('for the input field then there is no symbol', () {
      expect(formatMoneyInput(125050, 'EUR', locale: 'en'), '1,250.50');
      expect(formatMoneyInput(1500000, 'XAF', locale: 'fr'), '1,500,000');
      expect(formatMoneyInput(0, 'XAF', locale: 'en'), '0');
    });
  });

  group('Given typed text when it is read as an amount', () {
    final valid = <(String, String, String), int>{
      ('1500000', 'XAF', 'en'): 1500000,
      ('1,500,000', 'XAF', 'en'): 1500000,
      ('1 500 000', 'XAF', 'fr'): 1500000,
      ('1${nnbsp}500${nnbsp}000', 'XAF', 'fr'): 1500000,
      ('1 500 000', 'XAF', 'fr'): 1500000,
      // As the field shows it now, in French too.
      ('1,500,000', 'XAF', 'fr'): 1500000,
      ('1,250.50', 'EUR', 'en'): 125050,
      ('1250.5', 'EUR', 'en'): 125050,
      ('1 250,50', 'EUR', 'fr'): 125050,
      ('1250.50', 'EUR', 'fr'): 125050,
      ('12', 'USD', 'en'): 1200,
      ('  42  ', 'XAF', 'en'): 42,
      ('0', 'XAF', 'en'): 0,
    };
    for (final MapEntry(key: (text, code, locale), value: minor)
        in valid.entries) {
      test('"$text" in $code ($locale) then it is $minor', () {
        expect(parseMoney(text, code, locale: locale), minor);
      });
    }

    final invalid = <(String, String, String)>[
      ('', 'XAF', 'en'),
      ('abc', 'XAF', 'en'),
      ('-5', 'XAF', 'en'),
      ('12.5', 'XAF', 'en'),
      ('1.234', 'EUR', 'en'),
      ('1,2,3.4.5', 'EUR', 'en'),
      ('1000000000000001', 'XAF', 'en'),
    ];
    for (final (text, code, locale) in invalid) {
      test('"$text" in $code ($locale) then it is refused', () {
        expect(parseMoney(text, code, locale: locale), isNull);
      });
    }
  });

  test(
    'Given an amount when it is shown and read back then it is the same',
    () {
      for (final (minor, code, locale) in [
        (1500000, 'XAF', 'fr'),
        (125050, 'EUR', 'fr'),
        (99, 'USD', 'en'),
      ]) {
        expect(
          parseMoney(
            formatMoneyInput(minor, code, locale: locale),
            code,
            locale: locale,
          ),
          minor,
        );
      }
    },
  );
}
