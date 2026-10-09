import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Startup work and the app's single error-reporting entry point.
class AppInitializer {
  /// Runs before `runApp`: error hooks, services, saved session.
  Future<void> preAppRun() async {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      recordError(details.exception, details.stack ?? StackTrace.current);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      recordError(error, stack);
      return true;
    };

    ApiProvider().initialize(
      onUnauthorized: () {
        // Apps with sign-in: tell the AuthenticationBloc the session ended.
      },
    );
  }

  /// Runs right after `runApp`.
  Future<void> postAppRun() async {
    // Hide the red error screen from users in release builds.
    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) => const SizedBox();
    }
  }

  /// Every uncaught error ends up here (zone, framework, platform).
  /// Plug crash reporting in this one place, e.g.
  /// `FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)`.
  void recordError(Object error, StackTrace stack) {
    if (kDebugMode) {
      debugPrintStack(label: error.toString(), stackTrace: stack);
    } else {
      log('Uncaught error: $error', stackTrace: stack);
    }
  }
}
