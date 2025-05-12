import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(
      {super.key,
      this.messageWidget,
      this.buttons,
      required this.errorMessage,
      required this.onPressed,
      required this.refreshText});
  final Widget? messageWidget;
  final List<Widget>? buttons;
  final String errorMessage;
  final VoidCallback onPressed;
  final String refreshText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        alignment: Alignment.center,
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(30),
        insetPadding: const EdgeInsets.all(20),
        scrollable: true,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: ErrorrWidget(
            errorMessage: errorMessage,
            onPressed: onPressed,
            refreshText: refreshText));
  }
}
