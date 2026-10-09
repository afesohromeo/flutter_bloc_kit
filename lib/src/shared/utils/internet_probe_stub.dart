/// Returns whether a request can reach the internet.
typedef InternetProbe = Future<bool> Function();

/// Platforms without dart:io or a browser: trust the interface status.
Future<bool> hasInternetAccess() async => true;
