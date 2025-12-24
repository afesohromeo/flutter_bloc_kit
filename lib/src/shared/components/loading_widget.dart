import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.loadingText});

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const CircularProgressIndicator.adaptive(),
            const Gap.vertical(height: 10),
            Text(
              loadingText,
              textAlign: TextAlign.center,
              style:
                  AppTheme.lightTextTheme.displayLarge!.copyWith(fontSize: 14),
            ),
          ])),
    );
  }
}
