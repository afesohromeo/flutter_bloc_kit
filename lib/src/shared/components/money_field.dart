import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// An amount in [currencyCode], typed in the app language.
/// Empty means no amount yet; the caller reads the value with
/// [parseMoney]. Accepted: 0 to [maxMoneyMinor] minor units, with no more
/// decimals than the currency has (mirror your backend's check).
class MoneyField extends StatelessWidget {
  const MoneyField({
    super.key,
    required this.controller,
    required this.currencyCode,
    required this.labelText,
  });

  final TextEditingController controller;
  final String currencyCode;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return InputField(
      controller: controller,
      labelText: labelText,
      keyboardType: TextInputType.numberWithOptions(
        decimal: currencyDigits(currencyCode) > 0,
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        // The symbol, as amounts are written: FCFA.
        child: Text(
          currencySymbol(currencyCode),
          style: context.textTheme.bodyMedium,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) return null;
        return parseMoney(value, currencyCode, locale: locale) == null
            ? l10n.validateAmountInvalid
            : null;
      },
    );
  }
}
