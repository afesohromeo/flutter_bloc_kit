import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class ScaffoldWrapperProps {
  final Widget? leading;
  final Widget? title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNav;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? floatingButtonPadding;
  final Widget? buttonIcon;
  final Color? buttonColor;
  final bool? mini;
  final bool resizeToAvoidBottomInset;
  final bool showBottomNav;
  final bool showFloatingButton;
  final bool hasAppbar;
  final Color appBarBgColor;
  final Color bgColor;
  final double? elevation;
  final double? toolBarHeight;
  final bool? showDrawer;

  const ScaffoldWrapperProps(
      {this.leading,
      this.title,
      this.bottom,
      this.actions,
      this.floatingActionButtonLocation,
      this.bottomNav,
      this.onPressed,
      this.floatingButtonPadding,
      this.buttonIcon,
      this.buttonColor,
      this.mini,
      this.resizeToAvoidBottomInset = false,
      this.showBottomNav = false,
      this.showFloatingButton = false,
      this.hasAppbar = true,
      this.appBarBgColor = AppColors.white1,
      this.bgColor = AppColors.white1,
      this.elevation,
      this.toolBarHeight,
      this.showDrawer = true});
}
