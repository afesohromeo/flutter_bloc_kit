import 'dart:async';
import 'dart:developer';
import 'dart:io';

/// Returns whether a request can reach the internet.
typedef InternetProbe = Future<bool> Function();

/// Mobile and desktop: a DNS lookup proves that requests can get out.
Future<bool> hasInternetAccess() async {
  try {
    final addresses = await InternetAddress.lookup('example.com')
        .timeout(const Duration(seconds: 5));
    return addresses.isNotEmpty && addresses.first.rawAddress.isNotEmpty;
  } on SocketException {
    return false;
  } on TimeoutException {
    log('NetworkConnectivity: internet probe timed out');
    return false;
  }
}
