import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Calls [onReturn] when the router's address comes back to its page, after
/// a page above it was closed (Back, or going to this page's address). With
/// nested routes the page below stays alive, so without this it would show
/// what it loaded before. Not called when the page is first
/// shown.
///
/// It follows the address, not the route stack: dialogs, menus and sheets
/// don't change the address, so closing one doesn't reload. Reloading then
/// raced with the action the dialog had confirmed.
class ReloadOnReturn extends StatefulWidget {
  const ReloadOnReturn({
    super.key,
    required this.onReturn,
    required this.child,
  });

  final VoidCallback onReturn;
  final Widget child;

  @override
  State<ReloadOnReturn> createState() => _ReloadOnReturnState();
}

class _ReloadOnReturnState extends State<ReloadOnReturn> {
  GoRouter? _router;

  /// The address of this widget's page, e.g. `/projects/7`.
  String? _location;
  bool _isShown = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final router = GoRouter.maybeOf(context);
    if (router == _router) return;
    _router?.routerDelegate.removeListener(_onAddressChanged);
    _router = router;
    // No router in some widget tests: nothing to follow.
    if (router == null) return;
    _location = GoRouterState.of(context).matchedLocation;
    // Not shown yet when built under a page opened directly (e.g. from a
    // notification): closing that page is a return too.
    _isShown = router.routerDelegate.currentConfiguration.uri.path == _location;
    router.routerDelegate.addListener(_onAddressChanged);
  }

  void _onAddressChanged() {
    final router = _router;
    if (router == null || !mounted) return;
    final isShown =
        router.routerDelegate.currentConfiguration.uri.path == _location;
    if (isShown && !_isShown) widget.onReturn();
    _isShown = isShown;
  }

  @override
  void dispose() {
    _router?.routerDelegate.removeListener(_onAddressChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
