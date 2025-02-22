import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_kit/src/core/core.dart';
import 'package:flutter_bloc_kit/src/core/theme/dimens.dart';
import 'package:flutter_bloc_kit/src/features/home/logic/counter_cubit.dart';
import 'package:flutter_bloc_kit/src/shared/components/gap.dart';
import 'package:flutter_bloc_kit/src/shared/extensions/context_extensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.count,
                style: context.textTheme.bodyLarge,
              ),
              const Gap.vertical(height: Dimens.spacing),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    '${state.value}',
                    style: context.textTheme.headlineLarge,
                  );
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterCubit>().increment(),
          child: const Icon(Icons.add),
        ));
  }
}
