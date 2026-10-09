import 'package:flutter/material.dart';

class AppRestart extends StatefulWidget {
  final Widget child;

  const AppRestart({super.key, required this.child});

  static void restart(BuildContext context) {
    final state = context.findAncestorStateOfType<_AppRestartState>();
    state?.restart();
  }

  @override
  State<AppRestart> createState() => _AppRestartState();
}

class _AppRestartState extends State<AppRestart> {
  Key _key = UniqueKey();

  void restart() {
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
