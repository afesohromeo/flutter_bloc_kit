import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Shows a success or error dialog, then auto-dismisses after a timeout.
/// Returns a [Future] that completes once the dialog is closed (either by user or timeout).
Future<void> showSuccessErrorDialog(
  BuildContext context,
  String message,
  bool isSuccess, {
  bool shouldPopDialog = false,
}) async {
  log('😡');
  try {
    final completer = Completer<void>();

    // Use root navigator context for dialogs
    final dialogContext = Navigator.of(context, rootNavigator: true).context;

    // Optionally pop the current page before showing dialog
    if (isSuccess && shouldPopDialog) {
      log('poping diiii');

      context.pop();
    } else if (shouldPopDialog) {
      log('poping diiii');

      context.pop();
    }

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!dialogContext.mounted) {
        if (!completer.isCompleted) completer.complete();
        return;
      }

      // Show dialog
      showDialog(
        context: dialogContext,
        useRootNavigator: true,
        barrierDismissible: true,
        builder: (_) => isSuccess
            ? Congratulations(
                message: message,
                parentContext: dialogContext,
              )
            : ErrorDialog(
                message: message,
                parentContext: dialogContext,
              ),
      ).then((_) {
        if (!completer.isCompleted) completer.complete();
      });

      // Auto-close after a delay
      Future.delayed(Duration(seconds: isSuccess ? 3 : 10), () {
        if (!completer.isCompleted && dialogContext.mounted) {
          Navigator.of(dialogContext, rootNavigator: true).maybePop();
          if (!completer.isCompleted) completer.complete();
        }
      });
    });

    return completer.future;
  } catch (e) {
    log('😒😒😒😒 $e');
  }
}
