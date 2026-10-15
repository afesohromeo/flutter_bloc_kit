import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:go_router/go_router.dart';

/// App-bar back button for pages nested under another route.
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.color});

  /// Defaults to the text colour; pass a light colour on a dark app bar.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      tooltip: AppLocalizations.of(context)!.back,
      icon: Icon(Icons.arrow_back_ios, color: color ?? customColors.black1),
      onPressed: () => context.pop(),
    );
  }
}
