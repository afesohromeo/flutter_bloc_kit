import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// Application name, shown by the OS (task switcher, browser tab)
  ///
  /// In en, this message translates to:
  /// **'Flutter BLoC Kit'**
  String get appTitle;

  /// Button that closes a dialog
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Button text to cancel an action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Button text to confirm an action
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Button text to proceed with an action
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// Button text to reload content
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Button text to retry after an error
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// Search field placeholder
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Generic loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Shown when a list or page has nothing to display
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// Tooltip of the button that opens the navigation drawer
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get openMenu;

  /// Label for telephone field
  ///
  /// In en, this message translates to:
  /// **'Tel'**
  String get tel;

  /// Placeholder text for country search field
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// Phone number validation: number not valid for the selected country
  ///
  /// In en, this message translates to:
  /// **'Invalid mobile number'**
  String get validateMobile1;

  /// Validation: a required field is empty
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validateRequired;

  /// Validation: email field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get validateEmailRequired;

  /// Validation: email has an invalid format
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validateEmailInvalid;

  /// Validation: password field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get validatePasswordRequired;

  /// Validation: password has leading or trailing spaces
  ///
  /// In en, this message translates to:
  /// **'The password can\'t start or end with a space'**
  String get validatePasswordSpaces;

  /// Validation: password shorter than the minimum length
  ///
  /// In en, this message translates to:
  /// **'Use at least {minLength} characters'**
  String validatePasswordTooShort(int minLength);

  /// Validation: confirm-password field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter the password again'**
  String get validateConfirmPasswordRequired;

  /// Validation: confirm-password differs from the password
  ///
  /// In en, this message translates to:
  /// **'The passwords don\'t match'**
  String get validatePasswordMismatch;

  /// Validation: name field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get validateNameRequired;

  /// Validation: name longer than the maximum length
  ///
  /// In en, this message translates to:
  /// **'Use at most {maxLength} characters'**
  String validateNameTooLong(int maxLength);

  /// Error: the server answered 401 (not signed in or session expired)
  ///
  /// In en, this message translates to:
  /// **'Your session has ended. Please sign in again.'**
  String get errorUnauthorized;

  /// Error: no connection, timeout or server unavailable
  ///
  /// In en, this message translates to:
  /// **'Can\'t reach the server. Check your connection and try again.'**
  String get networkError;

  /// Dropdown: loading its list of options failed
  ///
  /// In en, this message translates to:
  /// **'The options couldn\'t be loaded.'**
  String get errorLoadingOptions;

  /// Title of the home page and its drawer entry
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Welcome text on the kit's placeholder home page
  ///
  /// In en, this message translates to:
  /// **'Your app starts here.'**
  String get homeWelcome;

  /// Button on the home page that opens the reference list feature
  ///
  /// In en, this message translates to:
  /// **'See the example list'**
  String get homeOpenItems;

  /// Title of the reference list page and its drawer entry
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get itemsTitle;

  /// Search field label on the items page
  ///
  /// In en, this message translates to:
  /// **'Search items'**
  String get itemsSearchHint;

  /// Items page: the list is empty
  ///
  /// In en, this message translates to:
  /// **'There are no items yet.'**
  String get itemsEmptyState;

  /// Items page: a search returned nothing
  ///
  /// In en, this message translates to:
  /// **'No items match your search.'**
  String get itemsSearchEmptyState;

  /// Items page: loading a page of items failed
  ///
  /// In en, this message translates to:
  /// **'The items couldn\'t be loaded.'**
  String get errorLoadingItems;

  /// Items page banner when the app runs without a backend URL
  ///
  /// In en, this message translates to:
  /// **'Demo data. Set BASE_URL to load items from your API.'**
  String get itemsDemoNotice;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
