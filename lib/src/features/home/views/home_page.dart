import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:go_router/go_router.dart';

/// Placeholder home page: replace it with your app's first screen.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const openItemsButtonKey = Key('homePage.openItems');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ResponsiveScaffoldWrapper(
      props: ScaffoldWrapperProps(
        appBarBgColor: customColors.background,
        elevation: 0,
        leading: ResponsiveLayout.isDesktop(context)
            ? null
            : Builder(
                builder: (context) => IconButton(
                  tooltip: l10n.openMenu,
                  icon: Icon(Icons.menu, color: customColors.black1),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        title: Text(
          l10n.homeTitle,
          style: context.textTheme.titleLarge?.copyWith(
            color: customColors.black1,
          ),
        ),
      ),
      mobileBody: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.homeWelcome,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: customColors.black1,
                ),
              ),
              const Gap.vertical(height: 24),
              PrimaryButton(
                key: openItemsButtonKey,
                height: 48,
                width: 260,
                onPressed: () => context.goNamed(itemsRouteName),
                child: Text(
                  l10n.homeOpenItems,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: customColors.background,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
