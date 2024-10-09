import 'dart:async';
import 'dart:developer';

// import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  NetworkConnectivity._();
  static final instance = NetworkConnectivity._();

  static Future<bool> checkConnectionStatus() async {
    // List<ConnectivityResult> result = await Connectivity().checkConnectivity();

    // bool isOnline = false;

    // if (result.any((test) => test != ConnectivityResult.none)) {
    //   try {
    //     final result = await InternetAddress.lookup('example.com');
    //     isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    //   } on SocketException catch (_) {
    //     isOnline = false;
    //     return isOnline;
    //   }
    //   return isOnline;
    // } else {
    //   return isOnline;
    // }
    log('message connect');
    return true;
  }
}
