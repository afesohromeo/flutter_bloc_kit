import 'package:web/web.dart' as web;

/// Returns whether a request can reach the internet.
typedef InternetProbe = Future<bool> Function();

/// Web: the browser knows; DNS lookups aren't available.
Future<bool> hasInternetAccess() async => web.window.navigator.onLine;
