// import 'package:dashboard_commande/src/core/core.dart';
// import 'package:dashboard_commande/src/shared/components/components.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class Congratulations extends StatelessWidget {
//   const Congratulations({super.key, this.messageWidget, this.buttons});
//   final Widget? messageWidget;
//   final List<Widget>? buttons;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//         alignment: Alignment.center,
//         titlePadding: EdgeInsets.zero,
//         contentPadding: const EdgeInsets.all(30),
//         insetPadding: EdgeInsets.zero,
//         scrollable: true,
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         content: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 100,
//               height: 100,
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     // begin: Alignment.topLeft,
//                     // end: Alignment.bottomRight,
//                     stops: const [
//                       0.8,
//                       1,
//                     ],
//                     colors: [
//                       AppColors.success.withValues(alpha:.9),
//                       AppColors.success.withValues(alpha:.5),
//                     ],
//                   )),
//               child: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                 ),
//                 child: const Icon(
//                   Icons.check_rounded,
//                   color: AppColors.success,
//                   size: 75,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Text(
//               'Sauvegardé avec succès',
//               style: Theme.of(context)
//                   .textTheme
//                   .displayLarge!
//                   .copyWith(fontSize: 20),
//             ),

//             const SizedBox(
//               height: 30,
//             ),
//             // for (Widget button in buttons) ...[
//             //   button,
//             //   const SizedBox(
//             //     height: 20,
//             //   ),
//             // ]
//             PrimaryButton(
//                 height: 55,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0)),
//                 inkRaduis: 10,
//                 child: Text(
//                   'Fermer',
//                   style: AppTheme.lightTextTheme.displayMedium!
//                       .copyWith(color: Colors.white, fontSize: 16),
//                 ),
//                 onPressed: () {
//                   context.pop();
//                 }),

//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ));
//   }
// }
