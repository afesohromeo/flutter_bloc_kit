import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();
  static const kUser = 'user';

  static const kToken = 'token';
  static const kRole = 'roles';

  static const kAuthorization = 'authorizations';
  static const kOpenedCaisse = 'openedCaisse';
  static const kCassier = 'caissier';

  static const kPendingOrders = 'perndingOrders';
  static const kBaseUrl = 'domainUrl';
  static const kTenant = 'tenant';
  static const kSelectedSite = 'selectedSite';
  static const kUserSites = 'userSites';
  static Future<String?> getSelectedSite() async {
    return (await _storage.read(key: kSelectedSite)) ?? '';
  }

  static Future<String?> getUserSites() async {
    return (await _storage.read(key: kUserSites)) ?? '';
  }

 
  static Future<String?> getTenant() async {
    return (await _storage.read(key: kTenant)) ?? '';
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

  static Future<void> saveCaisse(var caisse) async {
    await _storage.write(key: kOpenedCaisse, value: caisse);
  }

  static Future<void> saveCaissier(var caissier) async {
    await _storage.write(key: kCassier, value: caissier);
  }

  static Future<void> savePendingOrders(var pendingOrders) async {
    await _storage.write(key: kPendingOrders, value: pendingOrders);
  }

  static Future<String?> getPendingOrders() async {
    return (await _storage.read(key: kPendingOrders)) ?? '';
  }

  static Future<String?> getCaisse() async {
    return (await _storage.read(key: kOpenedCaisse)) ?? '';
  }

  static Future<String?> getCaissier() async {
    return (await _storage.read(key: kCassier)) ?? '';
  }

  static Future<String?> getBaseUrl() async {
    return (await _storage.read(key: kBaseUrl)) ?? '';
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }

  static Future<void> deleteCaisse() async {
    await _storage.delete(key: kCassier);
    await _storage.delete(key: kOpenedCaisse);
    await _storage.delete(key: kPendingOrders);
  }
}
