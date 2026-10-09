import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Small values that must survive restarts and stay private: tokens, the
/// signed-in user, simple flags. Since flutter_secure_storage 10, storage that
/// can't be decrypted (e.g. after an Android backup restore) is reset instead
/// of throwing.
class SecureStorageHelper {
  SecureStorageHelper._();

  static const _storage = FlutterSecureStorage();

  static const kToken = 'token';
  static const kUser = 'user';

  static Future<void> saveToken(String token) =>
      _storage.write(key: kToken, value: token);

  static Future<String?> getToken() => _storage.read(key: kToken);

  static Future<void> deleteToken() => _storage.delete(key: kToken);

  /// The signed-in user, usually as a JSON string.
  static Future<void> saveUser(String user) =>
      _storage.write(key: kUser, value: user);

  static Future<String?> getUser() => _storage.read(key: kUser);

  /// A boolean flag (e.g. "onboarding seen"); `false` when never set.
  static Future<bool> getFlag(String key) async =>
      (await _storage.read(key: key)) == 'true';

  static Future<void> setFlag(String key, bool value) =>
      _storage.write(key: key, value: value.toString());

  static Future<void> clearAll() => _storage.deleteAll();
}
