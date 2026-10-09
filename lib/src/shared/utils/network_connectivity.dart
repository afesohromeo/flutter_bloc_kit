import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Checks whether the device can actually reach the internet.
///
/// A network interface being up (Wi-Fi, mobile data) isn't enough: captive
/// portals and dead access points report "connected". So, when an interface
/// is up, [probe] checks that a request can get out (a DNS lookup on mobile
/// and desktop; on web the browser's own status is used).
class NetworkConnectivity {
  NetworkConnectivity({Connectivity? connectivity, InternetProbe? probe})
    : _connectivity = connectivity ?? Connectivity(),
      _probe = probe ?? hasInternetAccess;

  /// The app-wide instance.
  static final instance = NetworkConnectivity();

  final Connectivity _connectivity;
  final InternetProbe _probe;

  /// Shorthand for `NetworkConnectivity.instance.isOnline()`.
  static Future<bool> checkConnectionStatus() => instance.isOnline();

  Future<bool> isOnline() async =>
      _isOnline(await _connectivity.checkConnectivity());

  /// Emits `true` / `false` each time the online status changes.
  Stream<bool> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged.asyncMap(_isOnline).distinct();

  Future<bool> _isOnline(List<ConnectivityResult> results) async {
    if (results.every((result) => result == ConnectivityResult.none)) {
      return false;
    }
    return _probe();
  }
}
