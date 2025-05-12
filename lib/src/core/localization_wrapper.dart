import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/src/core/core.dart';

class LocalizationWrapper extends StatelessWidget {
  const LocalizationWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Localizations(
        delegates: AppLocalizations.localizationsDelegates,
        locale: const Locale('fr'), // Set the default locale
        child: child);
  }
}
