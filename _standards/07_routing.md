# Routing

## System Used

**GoRouter** with:
- Named routes (name constants in `route_names.dart`, path constants in `route_paths.dart`)
- **Nested routes** that mirror the page hierarchy, so Android Back goes up one level
- An auth-state redirect guard (apps with sign-in), refreshed by the `AuthenticationBloc` stream
- A global `NavigatorState` key for programmatic navigation
- Optional bottom-navigation shell (`StatefulShellRoute.indexedStack`)

---

## Route Constants

**File:** `lib/src/core/routing/route_names.dart`
```dart
// Pattern: const String {feature}RouteName = 'kebab-case-name';
const String homeRouteName = 'home';
const String itemsRouteName = 'items';
const String itemDetailRouteName = 'item-detail';
```

**File:** `lib/src/core/routing/route_paths.dart`
```dart
// Top-level paths start with '/'; nested (child) paths don't.
const String homePage = '/';
const String itemsPage = 'items';          // → /items
const String itemDetailPage = ':itemId';   // → /items/42
```

---

## Route Manager

**File:** `lib/src/core/routing/route_manager.dart`

```dart
class RouteManager {
  RouteManager({AuthenticationBloc? authBloc}) : _authBloc = authBloc {
    router = createRouter();
  }

  final AuthenticationBloc? _authBloc;
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  late final GoRouter router;

  GoRouter createRouter() {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: kDebugMode,
      initialLocation: homePage,
      refreshListenable:
          _authBloc == null ? null : GoRouterRefreshStream(_authBloc.stream),
      redirect: _redirect,
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
                  key: state.pageKey, child: const ItemsPage()),
              routes: [
                GoRoute(
                  name: itemDetailRouteName,
                  path: itemDetailPage,
                  pageBuilder: (context, state) => NoTransitionPage<void>(
                    key: state.pageKey,
                    child: ItemDetailPage(
                      itemId: int.parse(state.pathParameters['itemId']!),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ];
}
```

---

## Auth Guard (apps with sign-in)

```dart
enum AuthenticationStatus { unknown, authenticated, unauthenticated }

String? _redirect(BuildContext context, GoRouterState state) {
  final status = _authBloc?.state.status;
  if (status == null) return null;                       // app without sign-in
  final onSignIn = state.matchedLocation == signInPage;
  final isPublic = publicPaths.contains(state.matchedLocation); // e.g. sign-up, reset
  switch (status) {
    case AuthenticationStatus.unknown:
    case AuthenticationStatus.unauthenticated:
      return (onSignIn || isPublic) ? null : signInPage;
    case AuthenticationStatus.authenticated:
      return onSignIn ? homePage : null;
  }
}
```

- The `AuthenticationBloc` starts with the **known** status (the saved session is restored in `AppInitializer.preAppRun()` before the first frame), so the guard never flashes the sign-in page.
- Deep links that need sign-in (e.g. invitation links) are kept in a query parameter (`?from=`) and resumed after sign-in.

---

## Nested Routes ⭐

- Routes are **nested by hierarchy**: a detail page is a child of its list page, which is a child of home.
- `context.goNamed(itemDetailRouteName, pathParameters: {...})` then builds the whole stack, so Android Back and the app bar back button go **up one level**, not out of the app.
- Pages that are reached from several places and must return to the caller use `context.pushNamed(...)` instead.

---

## Bottom Navigation (optional)

For apps with persistent tabs, wrap the tab routes in a `StatefulShellRoute.indexedStack`; each tab keeps its own navigation stack:

```dart
StatefulShellRoute.indexedStack(
  builder: (context, state, shell) => ScaffoldWithNav(
    navigationShell: shell,
    items: [
      NavItem(icon: Icons.map_outlined, activeIcon: Icons.map, label: l10n.map),
      NavItem(icon: Icons.bookmark_border, activeIcon: Icons.bookmark, label: l10n.saved),
    ],
  ),
  branches: [
    StatefulShellBranch(routes: [GoRoute(name: mapRouteName, path: mapPage, ...)]),
    StatefulShellBranch(routes: [GoRoute(name: savedRouteName, path: savedPage, ...)]),
  ],
)
```

`ScaffoldWithNav` and `AppBottomNavBar` live in the kit (08). Tab pages still use `ResponsiveScaffoldWrapper`, with `showDrawer: false`.

---

## Adding a New Route

1. Add the name to `route_names.dart` and the path to `route_paths.dart`.
2. Add a `GoRoute` (with `NoTransitionPage`) **under its parent route**.
3. Add a drawer or bottom-navigation entry if it's a top-level destination.

---

## Navigation

```dart
// Always named navigation
context.goNamed(itemsRouteName);
context.goNamed(itemDetailRouteName, pathParameters: {'itemId': '${item.id}'});

// From outside the widget tree
RouteManager.rootNavigatorKey.currentContext?.goNamed(homeRouteName);
```

**Never** `context.go('/items/42')` with a hand-built path: names survive path changes, strings don't.
