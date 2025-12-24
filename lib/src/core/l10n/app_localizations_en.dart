// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get count => 'Count';

  @override
  String get appTitle => 'Flutter bloc kit';

  @override
  String get refresh => 'Refresh';

  @override
  String get searchCountry => 'Search country';

  @override
  String get validateMobile1 => 'Invalid Mobile Number';

  @override
  String get tel => 'Tel';

  @override
  String get validateMobile2 => 'Phone number must start with 6.';

  @override
  String get authenticationRequired => 'Authentication Required';

  @override
  String get ok => 'Close';
}
