import 'dart:developer';

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

  static bool isMobile(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return (size.shortestSide < 600 || size.width <= 800);
  }

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 600 && size.shortestSide < 1100;
  }

  static bool isDesktop(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.shortestSide >= 1100;
  }

  final Widget Function()? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final shortestSide = MediaQuery.of(context).size.shortestSide;

        if (shortestSide < 600 || maxWidth <= 800) {
          log('building mobile $shortestSide ${shortestSide < 600 || maxWidth <= 800}');
          return mobile(context, child?.call());
        } else if (shortestSide < 1100 || (maxWidth > 800 && maxWidth < 1100)) {
          log('building tablet $shortestSide');
          return tablet(context, child?.call());
        } else {
          return desktop(context, child?.call());
        }
      },
    );
  }
}
