import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper(
      {super.key,
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
      this.bgColor = AppColors.white1,
      this.appBarBgColor = AppColors.white1,
      this.bottom,
      this.resizeToAvoidBottomInset = false,
      this.elevation,
      this.toolBarHeight});

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
  final Color bgColor;

  final Color appBarBgColor;
  final double? elevation;
  final double? toolBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: hasAppbar
          ? AppBar(
              shadowColor: appBarBgColor,
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

              // title of appbar
            )
          : null,
      body: body!,
      floatingActionButton: showFloatingButton
          ? Padding(
              padding:
                  floatingButtonpadding ?? const EdgeInsets.only(top: 65.0),
              child: FloatingActionButton(
                  mini: mini ?? true,
                  backgroundColor:
                      buttonColor ?? AppColors.secondary.withValues(alpha: .7),
                  shape: CircleBorder(
                      side: BorderSide(
                          color: buttonColor ?? AppColors.secondary)),
                  onPressed: onPressed,
                  child: buttonIcon ??
                      const Icon(
                        Icons.add,
                        size: 30,
                        color: AppColors.white1,
                      )),
            )
          : null,
      // drawer: const AppDrawer(),
    );
  }
}
