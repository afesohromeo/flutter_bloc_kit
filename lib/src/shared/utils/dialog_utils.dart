import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class DialogUtils {
  /// Generic success handler
  /// All objects (Blocs, services, etc.) must be captured BEFORE calling this.
  /// Do NOT use context inside postActions!
  static Future<void> handleSuccess(BuildContext context, String message,
      {List<void Function()> postActions = const [],
      bool shouldPopDialog = false}) async {
    // Capture actions to avoid modification during async
    final capturedActions = List<void Function()>.from(postActions);

    // Show the dialog (context is used only here)
    await showSuccessErrorDialog(context, message, true,
        shouldPopDialog: shouldPopDialog);

    // Execute actions safely without context
    for (var action in capturedActions) {
      try {
        action();
      } catch (e, st) {
        log('DialogUtils.handleSuccess postAction error: $e\n$st');
      }
    }
  }

  /// Generic failure handler
  /// All objects (Blocs, services, etc.) must be captured BEFORE calling this.
  /// Do NOT use context inside postActions!
  static Future<void> handleFailure(
    BuildContext context,
    String message, {
    List<void Function()> postActions = const [],
    bool shouldPopDialog = false,
  }) async {
    await showSuccessErrorDialog(
      context,
      message,
      false,
      shouldPopDialog: shouldPopDialog,
    );
  }
}
