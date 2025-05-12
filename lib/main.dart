import 'dart:async';

import 'package:flutter/material.dart';

import 'src/core/core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() {
  final AppInitializer appInitializer = AppInitializer();

  runZonedGuarded(
    () async {
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      await appInitializer.preAppRun();

      runApp(const Application());

      appInitializer.postAppRun();
    },
    (error, stack) {},
  );
}
