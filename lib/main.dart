import 'dart:async';

import 'package:flutter/material.dart';

import 'src/core/core.dart';

void main() {
  final AppInitializer appInitializer = AppInitializer();

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await appInitializer.preAppRun();

      runApp(const Application());

      appInitializer.postAppRun();
    },
    (error, stack) {},
  );
}
