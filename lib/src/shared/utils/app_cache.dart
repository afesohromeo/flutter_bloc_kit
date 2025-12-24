// import 'dart:developer';

// import 'package:shared_preferences/shared_preferences.dart';

// class AppCache {
//   static const kUser = 'user';

//   static const anonymous = 'anonymous';
//   static const kToken = 'token';

//   static const kLogin = 'login';

//   static const kBackendAddress = 'backendAddress';

//   Future<void> cacheUser(var user) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString(kUser, user);
//   }

//   Future<void> resetAddress() async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.remove(kBackendAddress);
//   }

//   Future<void> saveAddress(var address) async {
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString(kBackendAddress, address);
//   }

//   Future<String?> getAddress() async {
//     final prefs = await SharedPreferences.getInstance();
//     var r = prefs.getString(kBackendAddress);

//     return r;
//   }

//   Future<String?> getUser() async {
//     log('getting user');
//     final prefs = await SharedPreferences.getInstance();
//     var r = prefs.getString(kUser) ?? '';
//     log('getting user 2 $r');

//     return r;
//   }

//   Future<String?> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return (prefs.getString(kToken) ?? '');
//   }

//   Future<void> setToken(var token) async {
//     log('caching token $token');
//     final prefs = await SharedPreferences.getInstance();

//     await prefs.setString(kToken, (token));
//     log('cached success');
//   }

//   Future<void> setLogin(int count) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(kLogin, count == 1 ? true : false);
//   }

//   Future<bool?> hasLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(kLogin) ?? false;
//   }
// }
