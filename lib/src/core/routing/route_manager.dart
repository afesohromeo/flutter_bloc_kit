import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/src/core/core.dart';
import 'package:flutter_bloc_kit/src/features/features.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  RouteManager() {
    router = createRouter();
  }

  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router;
  GoRouter createRouter() {
    return GoRouter(
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: true,
        initialLocation: homePage,
        routes: [...shellSubRoutes]);
  }

  static List<RouteBase> get shellSubRoutes {
    return [
     
      GoRoute(
        name: homeRouteName,
        path: homePage,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const HomePage(),
          );
          //  slideTransition(
          //     state, const HomePage(), const Offset(0.0, 1.0));
        },
      ),
    ];
  }

  CustomTransitionPage slideTransition(
      GoRouterState state, Widget child, Offset begin) {
    return CustomTransitionPage<void>(
        key: state.pageKey,
        child: child,
        // transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          const end = Offset.zero;
          const curve = Curves.easeIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}
