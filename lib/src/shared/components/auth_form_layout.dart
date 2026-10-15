import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Body of form pages (welcome, sign-in, sign-up, password reset): centred,
/// scrollable, and at most 420 px wide on tablets and desktops. With
/// [onRefresh] the page can be pulled down to reload, even when its content
/// is shorter than the screen.
class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
    this.onRefresh,
  });

  static const double maxWidth = 420;

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: context.textTheme.headlineSmall),
          if (subtitle != null) ...[
            const Gap.vertical(height: AppSpacing.sm),
            Text(subtitle!, style: context.textTheme.bodyMedium),
          ],
          const Gap.vertical(height: AppSpacing.lg),
          ...children,
        ],
      ),
    );

    final refresh = onRefresh;
    if (refresh == null) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: content,
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: refresh,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - 2 * AppSpacing.lg,
            ),
            child: Center(child: content),
          ),
        ),
      ),
    );
  }
}
