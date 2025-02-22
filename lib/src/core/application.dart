import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/src/features/features.dart';
import 'package:provider/provider.dart';

import 'core.dart';

class Application extends StatelessWidget {
  const Application({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
        // MultiRepositoryProvider(
        //   providers: const [
        //     //Define all repositories used by the app here. Example
        //     //RepositoryProvider(create: (context) => AuthenticationRepository()),
        //   ],
        //   child:
        MultiBlocProvider(
      providers: [
        //Define all bloc used by the app here. Example
        // BlocProvider(
        //     create: (context) => ProfileBloc(
        //           userRepository: context.read<UserRepository>(),
        //         )..add(const ProfileLoaded())),
        // BlocProvider(
        //     create: (context) => AppointmentBloc(
        //           userRepository: context.read<UserRepository>(),
        //         )..add(const AppointmentInitialized())),

        BlocProvider(
          create: (_) => CounterCubit(),
          child: this,
        ),
      ],
      child: Builder(builder: (context) {
        return MultiProvider(
            providers: [
              Provider<RouteManager>(
                  lazy: false,
                  create: (BuildContext createContext) => RouteManager())
            ],
            child: Builder(builder: (context) {
              return const ApplicationView();
            }));
      }),
    )
        // )
        ;
  }
}
