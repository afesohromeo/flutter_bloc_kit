import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class ResponsiveScaffoldWrapper extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget? desktopBody;
  final ScaffoldWrapperProps props;

  const ResponsiveScaffoldWrapper({
    super.key,
    required this.mobileBody,
    this.tabletBody,
    this.desktopBody,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: (context, _) => ScaffoldWrapper(
        body: mobileBody,
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
      ),
      tablet: (context, _) => ScaffoldWrapper(
        body: tabletBody ?? mobileBody,
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
      ),
      desktop: (context, _) => ScaffoldWrapper(
        body: desktopBody ?? tabletBody ?? mobileBody,
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
      ),
    );
  }
}
