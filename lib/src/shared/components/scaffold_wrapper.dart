import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

enum DrawerMode {
  overlay, // mobile / tablet
  fixed, // desktop
}

/// The app's Scaffold. Pages use [ResponsiveScaffoldWrapper], which builds
/// this for each screen size; don't use it directly in a page.
class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    super.key,
    this.actions,
    this.leading,
    this.title,
    this.floatingActionButtonLocation,
    this.bottomNav,
    this.onPressed,
    this.floatingButtonpadding,
    this.buttonIcon,
    this.buttonColor,
    this.mini,
    required this.body,
    required this.showBottomNav,
    required this.showFloatingButton,
    required this.hasAppbar,
    this.bgColor,
    this.appBarBgColor,
    this.bottom,
    this.resizeToAvoidBottomInset = false,
    this.elevation,
    this.toolBarHeight,
    this.showDrawer = true,
    this.drawerMode = DrawerMode.overlay,
  });

  final Widget? body;
  final Widget? leading;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final bool showBottomNav;
  final bool hasAppbar;
  final bool showFloatingButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNav;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? floatingButtonpadding;
  final Widget? buttonIcon;
  final Color? buttonColor;
  final bool? mini;
  final bool? resizeToAvoidBottomInset;
  final Color? bgColor;
  final Color? appBarBgColor;
  final double? elevation;
  final double? toolBarHeight;
  final bool? showDrawer;
  final DrawerMode drawerMode;

  @override
  Widget build(BuildContext context) {
    final fab = Padding(
      padding: floatingButtonpadding ?? const EdgeInsets.only(top: 65.0),
      child: FloatingActionButton(
        mini: mini ?? true,
        backgroundColor:
            buttonColor ?? customColors.secondary.withValues(alpha: .7),
        shape: CircleBorder(
          side: BorderSide(color: buttonColor ?? customColors.secondary),
        ),
        onPressed: onPressed,
        child:
            buttonIcon ??
            Icon(Icons.add, size: 30, color: customColors.background),
      ),
    );

    return Scaffold(
      backgroundColor: bgColor ?? customColors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: hasAppbar
          ? AppBar(
              shadowColor: Colors.transparent,
              elevation: elevation ?? 10,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leadingWidth: 60,
              bottom: bottom,
              leading: leading,
              actions: actions,
              toolbarHeight: toolBarHeight ?? 65,
              backgroundColor: appBarBgColor,
              title: title,
              titleSpacing: 0,
            )
          : null,
      body: SafeArea(top: false, child: body!),
      floatingActionButton: showFloatingButton ? fab : null,
      bottomNavigationBar: showBottomNav ? bottomNav : null,
      drawer: drawerMode == DrawerMode.overlay && showDrawer == true
          ? AppDrawer(parentContext: context)
          : null,
    );
  }
}
