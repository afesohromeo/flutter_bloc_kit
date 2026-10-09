/// Build-time configuration, passed with `--dart-define`:
///
/// ```bash
/// flutter run --dart-define=env=prod --dart-define=BASE_URL=https://api.example.com
/// ```
///
/// Secrets (API keys) also come in this way, never as constants in the code.
class Environment {
  Environment._();

  /// `dev` (default), `staging` or `prod`.
  static const String environment = String.fromEnvironment(
    'env',
    defaultValue: 'dev',
  );

  /// The API's base URL. Empty means "no backend": the kit's reference
  /// feature then uses demo data.
  static const String baseUrl = String.fromEnvironment('BASE_URL');

  static bool get isProduction => environment == 'prod';
  static bool get isDevelopment => environment == 'dev';
  static bool get hasBackend => baseUrl.isNotEmpty;
}
