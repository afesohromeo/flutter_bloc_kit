import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();
  static const kUser = 'user';

  static const kToken = 'token';
  static const kRole = 'roles';

  static const kAuthorization = 'authorizations';

  static Future<void> saveToken(var token) async {
    await _storage.write(key: kToken, value: token);
  }

  static Future<void> saveUser(var user) async {
    await _storage.write(key: kUser, value: user);
  }

  static Future<void> saveRoles(var roles) async {
    await _storage.write(key: kRole, value: roles);
  }

  static Future<void> saveAuthorizations(var authorizations) async {
    await _storage.write(key: kAuthorization, value: authorizations);
  }

  static Future<String?> getToken() async {
    return (await _storage.read(key: kToken)) ?? '';
  }

  static Future<String?> getUser() async {
    return (await _storage.read(key: kUser)) ?? '';
  }

  static Future<String?> getRoles() async {
    return (await _storage.read(key: kRole)) ?? '';
  }

  static Future<String?> getAuthorizations() async {
    return (await _storage.read(key: kAuthorization)) ?? '';
  }

  static Future<void> clearAll() async {
    // final baseUrl = await getBaseUrl();
    await _storage.deleteAll();

    // await saveBaseUrl(baseUrl);
  }
}
