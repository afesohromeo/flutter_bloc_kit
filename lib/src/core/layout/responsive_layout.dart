import 'package:flutter/material.dart';

typedef ResponsiveWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayout extends StatelessWidget {
  final ResponsiveWidgetBuilder mobile;
  final ResponsiveWidgetBuilder tablet;
  final ResponsiveWidgetBuilder desktop;

  const ResponsiveLayout(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.desktop,
      this.child});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
      MediaQuery.of(context).size.width > 800;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  final Widget Function()? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final Size size = MediaQuery.of(context).size;
        final double maxWidth = constraints.maxWidth;

        if (maxWidth <= 800) {
          return mobile(context, child?.call());
        } else if (maxWidth < 1024 && maxWidth > 800) {
          return tablet(context, child?.call());
        } else {
          return desktop(context, child?.call());
        }
      },
    );
  }
}
