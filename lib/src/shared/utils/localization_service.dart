import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class LocalizationService {
  static AppLocalizations? _appLocalizations;

  static void setAppLocalizations(AppLocalizations localizations) {
    _appLocalizations = localizations;
  }

  static AppLocalizations get localization {
    if (_appLocalizations == null) {
      throw Exception('Localization has not been initialized yet.');
    }
    return _appLocalizations!;
  }
}
