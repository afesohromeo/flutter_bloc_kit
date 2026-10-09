// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter BLoC Kit';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get proceed => 'Proceed';

  @override
  String get refresh => 'Refresh';

  @override
  String get retry => 'Try again';

  @override
  String get search => 'Search';

  @override
  String get loading => 'Loading...';

  @override
  String get noData => 'No data';

  @override
  String get openMenu => 'Open menu';

  @override
  String get tel => 'Tel';

  @override
  String get searchCountry => 'Search country';

  @override
  String get validateMobile1 => 'Invalid mobile number';

  @override
  String get validateRequired => 'This field is required';

  @override
  String get validateEmailRequired => 'Enter your email address';

  @override
  String get validateEmailInvalid => 'Enter a valid email address';

  @override
  String get validatePasswordRequired => 'Enter your password';

  @override
  String get validatePasswordSpaces =>
      'The password can\'t start or end with a space';

  @override
  String validatePasswordTooShort(int minLength) {
    return 'Use at least $minLength characters';
  }

  @override
  String get validateConfirmPasswordRequired => 'Enter the password again';

  @override
  String get validatePasswordMismatch => 'The passwords don\'t match';

  @override
  String get validateNameRequired => 'Enter your name';

  @override
  String validateNameTooLong(int maxLength) {
    return 'Use at most $maxLength characters';
  }

  @override
  String get errorUnauthorized =>
      'Your session has ended. Please sign in again.';

  @override
  String get networkError =>
      'Can\'t reach the server. Check your connection and try again.';

  @override
  String get errorLoadingOptions => 'The options couldn\'t be loaded.';

  @override
  String get homeTitle => 'Home';

  @override
  String get homeWelcome => 'Your app starts here.';

  @override
  String get homeOpenItems => 'See the example list';

  @override
  String get itemsTitle => 'Items';

  @override
  String get itemsSearchHint => 'Search items';

  @override
  String get itemsEmptyState => 'There are no items yet.';

  @override
  String get itemsSearchEmptyState => 'No items match your search.';

  @override
  String get errorLoadingItems => 'The items couldn\'t be loaded.';

  @override
  String get itemsDemoNotice =>
      'Demo data. Set BASE_URL to load items from your API.';
}
