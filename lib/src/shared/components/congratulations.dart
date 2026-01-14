import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class Congratulations extends StatelessWidget {
  const Congratulations(
      {super.key,
      required this.message,
      this.onPressed,
      this.refreshText,
      required this.parentContext});

  final VoidCallback? onPressed;
  final String? refreshText;
  final String message;
  final BuildContext parentContext;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        alignment: Alignment.center,
        titlePadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(30),
        insetPadding: EdgeInsets.zero,
        scrollable: true,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    // begin: Alignment.topLeft,
                    // end: Alignment.bottomRight,
                    stops: const [
                      0.8,
                      1,
                    ],
                    colors: [
                      customColors.success.withValues(alpha: .9),
                      customColors.success.withValues(alpha: .5),
                    ],
                  )),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child:  Icon(
                  Icons.check_rounded,
                  color: customColors.success,
                  size: 75,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium),

            const SizedBox(
              height: 20,
            ),
            // for (Widget button in buttons) ...[
            //   button,
            //   const SizedBox(
            //     height: 20,
            //   ),
            // ]
            // PrimaryButton(
            //     height: 55,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0)),
            //     inkRaduis: 10,
            //     child: Text(
            //       'Fermer',
            //       style: context.textTheme.displayMedium!
            //           .copyWith(color: Colors.white, fontSize: 16),
            //     ),
            //     onPressed: () {
            //       context.pop();
            //     }),

            // const SizedBox(
            //   height: 30,
            // ),
          ],
        ));
  }
}
