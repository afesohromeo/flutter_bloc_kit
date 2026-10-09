import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Every page's root widget (_standards/06, RULE-043): the drawer is an
/// overlay on mobile and tablet, and a fixed 280 px sidebar on desktop.
class ResponsiveScaffoldWrapper extends StatelessWidget {
  const ResponsiveScaffoldWrapper({
    super.key,
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
    required this.props,
  });

  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;
  final ScaffoldWrapperProps props;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, _) => _scaffold(mobileBody, DrawerMode.overlay),
      tablet: (context, _) =>
          _scaffold(tabletBody ?? mobileBody, DrawerMode.overlay),
      desktop: (context, _) => Row(
        children: [
          if (props.showDrawer!)
            SizedBox(width: 280, child: AppDrawer(parentContext: context)),
          Expanded(
            child: ColoredBox(
              color: customColors.background,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: props.showDrawer! ? 10 : 0,
                ),
                child: _scaffold(
                  desktopBody ?? tabletBody ?? mobileBody,
                  DrawerMode.fixed,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scaffold(Widget body, DrawerMode drawerMode) {
    return ScaffoldWrapper(
      drawerMode: drawerMode,
      // The fixed desktop drawer is drawn beside the scaffold, not inside it.
      showDrawer: drawerMode == DrawerMode.overlay && props.showDrawer!,
      body: body,
      leading: props.leading,
      title: props.title,
      bottom: props.bottom,
      actions: props.actions,
      floatingActionButtonLocation: props.floatingActionButtonLocation,
      bottomNav: props.bottomNav,
      onPressed: props.onPressed,
      floatingButtonpadding: props.floatingButtonPadding,
      buttonIcon: props.buttonIcon,
      buttonColor: props.buttonColor,
      mini: props.mini,
      resizeToAvoidBottomInset: props.resizeToAvoidBottomInset,
      showBottomNav: props.showBottomNav,
      showFloatingButton: props.showFloatingButton,
      hasAppbar: props.hasAppbar,
      appBarBgColor: props.appBarBgColor,
      bgColor: props.bgColor,
      elevation: props.elevation,
      toolBarHeight: props.toolBarHeight,
    );
  }
}
