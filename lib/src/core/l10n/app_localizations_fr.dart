// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Flutter BLoC Kit';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get proceed => 'Continuer';

  @override
  String get refresh => 'Actualiser';

  @override
  String get retry => 'Réessayer';

  @override
  String get search => 'Rechercher';

  @override
  String get loading => 'Chargement...';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get openMenu => 'Ouvrir le menu';

  @override
  String get tel => 'Tél.';

  @override
  String get searchCountry => 'Rechercher un pays';

  @override
  String get validateMobile1 => 'Numéro de téléphone invalide';

  @override
  String get validateRequired => 'Ce champ est obligatoire';

  @override
  String get validateEmailRequired => 'Saisissez votre adresse e-mail';

  @override
  String get validateEmailInvalid => 'Saisissez une adresse e-mail valide';

  @override
  String get validatePasswordRequired => 'Saisissez votre mot de passe';

  @override
  String get validatePasswordSpaces =>
      'Le mot de passe ne peut pas commencer ni finir par une espace';

  @override
  String validatePasswordTooShort(int minLength) {
    return 'Utilisez au moins $minLength caractères';
  }

  @override
  String get validateConfirmPasswordRequired =>
      'Saisissez à nouveau le mot de passe';

  @override
  String get validatePasswordMismatch =>
      'Les mots de passe ne correspondent pas';

  @override
  String get validateNameRequired => 'Saisissez votre nom';

  @override
  String validateNameTooLong(int maxLength) {
    return 'Utilisez au plus $maxLength caractères';
  }

  @override
  String get errorUnauthorized =>
      'Votre session a expiré. Veuillez vous reconnecter.';

  @override
  String get networkError =>
      'Impossible de joindre le serveur. Vérifiez votre connexion et réessayez.';

  @override
  String get errorLoadingOptions => 'Les options n\'ont pas pu être chargées.';

  @override
  String get homeTitle => 'Accueil';

  @override
  String get homeWelcome => 'Votre application commence ici.';

  @override
  String get homeOpenItems => 'Voir la liste d\'exemple';

  @override
  String get itemsTitle => 'Éléments';

  @override
  String get itemsSearchHint => 'Rechercher des éléments';

  @override
  String get itemsEmptyState => 'Il n\'y a encore aucun élément.';

  @override
  String get itemsSearchEmptyState =>
      'Aucun élément ne correspond à votre recherche.';

  @override
  String get errorLoadingItems => 'Les éléments n\'ont pas pu être chargés.';

  @override
  String get itemsDemoNotice =>
      'Données de démonstration. Définissez BASE_URL pour charger les éléments depuis votre API.';
}
