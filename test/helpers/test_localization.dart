import 'package:flutter/widgets.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Makes `LocalizationService.localization` usable in BLoC and repository
/// tests (the app sets it at startup) and returns it for expected messages.
AppLocalizations setUpTestLocalization([Locale locale = const Locale('en')]) {
  final l10n = lookupAppLocalizations(locale);
  LocalizationService.setAppLocalizations(l10n);
  return l10n;
}
