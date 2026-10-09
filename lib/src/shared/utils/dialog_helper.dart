import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:go_router/go_router.dart';

/// Shows a success or error dialog, then closes it automatically (3 s for
/// success, 10 s for errors). Completes once the dialog is closed, by the user
/// or by the timeout. Use [DialogUtils] rather than calling this directly.
Future<void> showSuccessErrorDialog(
  BuildContext context,
  String message,
  bool isSuccess, {
  bool shouldPopDialog = false,
}) async {
  try {
    final completer = Completer<void>();

    // Dialogs go on the root navigator, above any nested navigator.
    final dialogContext = Navigator.of(context, rootNavigator: true).context;

    // Close the calling dialog or page first when asked to.
    if (shouldPopDialog) context.pop();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (!dialogContext.mounted) {
        if (!completer.isCompleted) completer.complete();
        return;
      }

      showDialog<void>(
        context: dialogContext,
        useRootNavigator: true,
        barrierDismissible: true,
        builder: (_) => isSuccess
            ? Congratulations(message: message, parentContext: dialogContext)
            : ErrorDialog(message: message, parentContext: dialogContext),
      ).then((_) {
        if (!completer.isCompleted) completer.complete();
      });

      Future.delayed(Duration(seconds: isSuccess ? 3 : 10), () {
        if (!completer.isCompleted && dialogContext.mounted) {
          Navigator.of(dialogContext, rootNavigator: true).maybePop();
          if (!completer.isCompleted) completer.complete();
        }
      });
    });

    return await completer.future; // RULE-041
  } catch (e) {
    log('showSuccessErrorDialog error: $e');
  }
}
