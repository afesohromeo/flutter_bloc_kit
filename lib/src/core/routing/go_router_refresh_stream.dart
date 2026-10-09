import 'dart:async';

import 'package:flutter/foundation.dart';

/// Turns a stream (e.g. an `AuthenticationBloc`'s) into the `Listenable`
/// GoRouter's `refreshListenable` expects, so redirects run again when the
/// stream emits. go_router stopped shipping this class in version 5.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    // Listen directly: wrapping in asBroadcastStream() would keep the source
    // subscription alive after dispose.
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
