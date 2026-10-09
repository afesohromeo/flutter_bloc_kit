import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:go_router/go_router.dart';

/// The app's routes, nested by page hierarchy so Back goes up one level
/// (_standards/07). Apps with sign-in add a `refreshListenable` and a
/// `redirect` here.
class RouteManager {
  RouteManager() {
    router = createRouter();
  }

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router;

  GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: homePage,
      routes: routes,
    );
  }

  static List<RouteBase> get routes => [
    GoRoute(
      name: homeRouteName,
      path: homePage,
      pageBuilder: (context, state) =>
          NoTransitionPage<void>(key: state.pageKey, child: const HomePage()),
      routes: [
        GoRoute(
          name: itemsRouteName,
          path: itemsPage,
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            // Page BLoCs are created with the page and closed with it.
            child: BlocProvider(
              create: (context) =>
                  ItemsBloc(repository: context.read<ItemRepository>()),
              child: const ItemsPage(),
            ),
          ),
        ),
      ],
    ),
  ];
}
