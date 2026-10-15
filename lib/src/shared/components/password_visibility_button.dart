import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Eye button at the end of a password field. The icon shows the current
/// state (open eye = visible, crossed eye = hidden); the tooltip says what a
/// tap does. The visibility state lives in the page's BLoC; this only shows
/// it and reports taps.
class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({
    super.key,
    required this.isVisible,
    required this.onPressed,
  });

  final bool isVisible;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      onPressed: onPressed,
      tooltip: isVisible ? l10n.hidePassword : l10n.showPassword,
      color: customColors.surface,
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
    );
  }
}
