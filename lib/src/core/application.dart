import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:provider/provider.dart';

/// Provides the app-wide dependencies: the router and the repositories.
///
/// App-wide BLoCs (e.g. an `AuthenticationBloc`) go in a `MultiBlocProvider`
/// around [ApplicationView]; page BLoCs are created by their route
/// (see `RouteManager`).
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        Provider<RouteManager>(create: (_) => RouteManager()),
        RepositoryProvider<ItemRepository>(create: (_) => ItemRepository()),
      ],
      child: const ApplicationView(),
    );
  }
}
