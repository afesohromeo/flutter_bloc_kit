import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  final appInitializer = AppInitializer();

  runZonedGuarded(() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await appInitializer.preAppRun();

    runApp(const AppRestart(child: Application()));
    await appInitializer.postAppRun();
  }, appInitializer.recordError);
}
