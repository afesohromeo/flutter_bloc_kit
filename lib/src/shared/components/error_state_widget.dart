import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Shown in place of content that failed to load, with a retry action.
/// (Named `ErrorStateWidget` because Flutter already has an `ErrorWidget`.)
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
    this.refreshText,
  });

  final String errorMessage;
  final VoidCallback onPressed;

  /// Defaults to the localized "Try again".
  final String? refreshText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: customColors.primary,
              size: 35,
            ),
            const Gap.vertical(height: 10),
            Text(
              errorMessage,
              style: context.textTheme.displayMedium!.copyWith(
                fontSize: 14,
                height: 2,
                wordSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap.vertical(height: 10),
            TextButton(
              onPressed: onPressed,
              child: Text(
                refreshText ?? AppLocalizations.of(context)!.retry,
                style: context.textTheme.displayLarge!.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
