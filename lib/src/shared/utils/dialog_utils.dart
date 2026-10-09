import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// The only way pages report the outcome of an action to the user
/// (_standards/06, RULE-039): a success or error dialog, then [postActions].
///
/// Capture BLoCs and other objects **before** calling; postActions must not
/// use `context`.
class DialogUtils {
  DialogUtils._();

  static Future<void> handleSuccess(
    BuildContext context,
    String message, {
    List<void Function()> postActions = const [],
    bool shouldPopDialog = false,
  }) async {
    final capturedActions = List<void Function()>.from(postActions);
    await showSuccessErrorDialog(
      context,
      message,
      true,
      shouldPopDialog: shouldPopDialog,
    );
    _run(capturedActions, 'handleSuccess');
  }

  static Future<void> handleFailure(
    BuildContext context,
    String message, {
    List<void Function()> postActions = const [],
    bool shouldPopDialog = false,
  }) async {
    final capturedActions = List<void Function()>.from(postActions);
    await showSuccessErrorDialog(
      context,
      message,
      false,
      shouldPopDialog: shouldPopDialog,
    );
    _run(capturedActions, 'handleFailure');
  }

  static void _run(List<void Function()> actions, String caller) {
    for (final action in actions) {
      try {
        action();
      } catch (e, st) {
        log('DialogUtils.$caller postAction error: $e\n$st');
      }
    }
  }
}
