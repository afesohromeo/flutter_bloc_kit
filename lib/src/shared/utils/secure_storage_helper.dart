import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const _storage = FlutterSecureStorage();
  static const kUser = 'user';
  static const kClient = 'client';

  static const kToken = 'token';
  static const kInstallationMode = 'installationMode';
  static const kRole = 'roles';

  static const kAuthorization = 'authorizations';
  static const kOpenedCaisse = 'openedCaisse';
  static const kCassier = 'caissier';

  static const kPendingOrders = 'perndingOrders';
  static const kBaseUrl = 'domainUrl';
  static const kTenant = 'tenant';
  static const kSelectedSite = 'selectedSite';
  static const kUserSites = 'userSites';
  static const kSelectedHabilitation = 'selectedHabilitation';
  static const kRoleAdminActivated = 'roleAdminActivated';
  static const kModeleImpressionPos = 'modeleImpressionPos';
  static const kCartSessionId = 'cartSessionId';

  static Future<String?> getModeleImpressionPos() async {
    return (await _storage.read(key: kModeleImpressionPos)) ?? '';
  }

  static Future<void> saveModeleImpressionPos(var modeleImpressionPos) async {
    await _storage.write(key: kModeleImpressionPos, value: modeleImpressionPos);
  }

  static Future<void> saveRoleAdminActivated(var roleAdminActivated) async {
    await _storage.write(key: kRoleAdminActivated, value: roleAdminActivated);
  }

  static Future<void> saveSelectedHabilitation(var selectedHab) async {
    await _storage.write(key: kSelectedHabilitation, value: selectedHab);
  }

  static Future<void> saveSelectedUserSite(var selectedSite) async {
    await _storage.write(key: kSelectedSite, value: selectedSite);
  }

  static Future<void> saveUserSites(var userSites) async {
    await _storage.write(key: kUserSites, value: userSites);
  }

  static Future<void> saveBaseUrl(var url) async {
    await _storage.write(key: kBaseUrl, value: url);
  }

  static Future<void> saveTenant(var tenant) async {
    await _storage.write(key: kTenant, value: tenant);
  }

  static Future<void> saveToken(var token) async {
    await _storage.write(key: kToken, value: token);
  }

  static Future<void> saveUser(var user) async {
    await _storage.write(key: kUser, value: user);
  }

  static Future<void> saveClient(var client) async {
    await _storage.write(key: kClient, value: client);
  }

  static Future<void> saveRoles(var roles) async {
    await _storage.write(key: kRole, value: roles);
  }

  static Future<void> saveAuthorizations(var authorizations) async {
    await _storage.write(key: kAuthorization, value: authorizations);
  }

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

  static Future<String?> getClient() async {
    return (await _storage.read(key: kClient)) ?? '';
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

  static Future<void> resetBaseUrl() async {
    await _storage.delete(key: kBaseUrl);
  }

  static Future<void> clear() async {
    final baseUrl = await getBaseUrl();
    final cartSession = await getCartSessionId();

    await _storage.deleteAll();
    await saveBaseUrl(baseUrl);
    await saveCartSessionId(cartSession!);
  }

  static Future<void> clearAll() async {
    // final baseUrl = await getBaseUrl();
    await _storage.deleteAll();

    // await saveBaseUrl(baseUrl);
  }

  static Future<void> deleteCaisse() async {
    await _storage.delete(key: kCassier);
    await _storage.delete(key: kOpenedCaisse);
    await _storage.delete(key: kPendingOrders);
  }

  // Cart Session ID methods
  static Future<void> saveCartSessionId(String sessionId) async {
    await _storage.write(key: kCartSessionId, value: sessionId);
  }

  static Future<String?> getCartSessionId() async {
    return await _storage.read(key: kCartSessionId);
  }

  static Future<void> deleteCartSessionId() async {
    await _storage.delete(key: kCartSessionId);
  }

  // installation mode
  static Future<void> saveInstallationMode(var mode) async {
    await _storage.write(key: kInstallationMode, value: mode);
  }

  static Future<String?> getInstallationMode() async {
    return (await _storage.read(key: kInstallationMode)) ?? '';
  }
}
