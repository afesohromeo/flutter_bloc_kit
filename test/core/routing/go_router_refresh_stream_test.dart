import 'dart:async';

import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Given GoRouterRefreshStream', () {
    test('when the stream emits then listeners are notified', () async {
      final controller = StreamController<int>();
      final refresh = GoRouterRefreshStream(controller.stream);
      var notifications = 0;
      refresh.addListener(() => notifications++);

      controller
        ..add(1)
        ..add(2);
      await Future<void>.delayed(Duration.zero);

      expect(notifications, 2);
      refresh.dispose();
      await controller.close();
    });

    test('when disposed then it stops listening to the stream', () async {
      final controller = StreamController<int>.broadcast();
      GoRouterRefreshStream(controller.stream).dispose();

      expect(controller.hasListener, isFalse);
      await controller.close();
    });
  });
}
