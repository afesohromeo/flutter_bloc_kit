import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class ErrorrWidget extends StatelessWidget {
  const ErrorrWidget(
      {super.key,
      required this.errorMessage,
      required this.onPressed,
      required this.refreshText});

  final String errorMessage;
  final VoidCallback onPressed;
  final String refreshText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        // padding:
        //     const EdgeInsets.fromLTRB(10, 0, 16, kBottomNavigationBarHeight),
        // physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.warning_amber_rounded,
              color: customColors.primary,
              size: 35,
            ),
            const Gap.vertical(
              height: 10,
            ),
            Text(
              errorMessage,
              style: context.textTheme.displayMedium!
                  .copyWith(fontSize: 14, height: 2, wordSpacing: 1.5),
              textAlign: TextAlign.center,
            ),
            const Gap.vertical(
              height: 10,
            ),
            TextButton(
                onPressed: onPressed,
                child: Text(
                  refreshText,
                  style: context.textTheme.displayLarge!.copyWith(fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
