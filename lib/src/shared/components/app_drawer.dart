import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:go_router/go_router.dart';

/// The navigation drawer: an overlay on mobile and tablet, a fixed sidebar on
/// desktop. Add one [DrawerTile] per top-level destination.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.parentContext});

  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentRoute = GoRouterState.of(parentContext).topRoute?.name;
    final isOverlay = !ResponsiveLayout.isDesktop(context);

    void open(String routeName) {
      if (isOverlay) Navigator.of(context).pop(); // close the overlay drawer
      parentContext.goNamed(routeName);
    }

    return Drawer(
      elevation: 20,
      backgroundColor: customColors.background,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, kToolbarHeight, 10, 20),
        children: [
          DrawerTile(
            title: l10n.homeTitle,
            iconData: Icons.home_outlined,
            selected: currentRoute == homeRouteName,
            onTap: () => open(homeRouteName),
            isVisible: true,
          ),
          DrawerTile(
            title: l10n.itemsTitle,
            iconData: Icons.list_alt_outlined,
            selected: currentRoute == itemsRouteName,
            onTap: () => open(itemsRouteName),
            isVisible: true,
          ),
        ],
      ),
    );
  }
}
