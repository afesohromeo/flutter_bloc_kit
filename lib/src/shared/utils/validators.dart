// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc_kit/src/core/core.dart';

// class Validators {
//   Validators({required BuildContext context}) : _context = context;

//   final BuildContext _context;
//   String? password;

//   String? validateEmail(String? value) {
//     String pattern =
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//     RegExp regExp = RegExp(pattern);
//     if (value!.isEmpty) {
//       return AppLocalizations.of(_context)!.validateEmail1;
//     } else if (!regExp.hasMatch(value)) {
//       return AppLocalizations.of(_context)!.validateEmail2;
//     } else {
//       return null;
//     }
//   }

//   String? validateIndex(String? value) {
//     // String pattern = r'^[a-z0-9,\.]+\-?[0-9a-z]+$';
//     // RegExp regExp = RegExp(pattern);
//     if (value!.isEmpty) {
//       return 'Please insert index';
//     } else if (value.length < 5) {
//       return 'Invalid index';
//     } else {
//       return null;
//     }
//   }

//   String? validatePassword(String? value) {
//     password = value;
//     if (value!.isEmpty) {
//       return AppLocalizations.of(_context)!.validatePassword1;
//     } else if (value.length < 8) {
//       return AppLocalizations.of(_context)!.validatePassword2;
//     }
//     return null;
//   }

//   // String? validateCurrentPassword(String? value) {
//   //   if (value!.isEmpty) {
//   //     return AppLocalizations.of(_context)!.validateCurrentPassword1;
//   //   } else if (value.length < 8) {
//   //     return AppLocalizations.of(_context)!.validatePassword2;
//   //   }
//   //   return null;
//   // }

//   String? validateConfirmPassword(String? value) {
//     if (value!.isEmpty) {
//       return AppLocalizations.of(_context)!.validatePassword1;
//     } else if (value.length < 8) {
//       return AppLocalizations.of(_context)!.validatePassword2;
//     } else if (value != password) {
//       return AppLocalizations.of(_context)!.validateConfirmPassword1;
//     }
//     return null;
//   }

//   String? validateAddress(String? value) {
//     final RegExp ipv4RegExp = RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$');
//     final RegExp ipv6RegExp =
//         RegExp(r'^(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
//     if (value!.isEmpty) {
//       return 'Please enter address';
//     } else if (!ipv4RegExp.hasMatch(value) && !ipv6RegExp.hasMatch(value)) {
//       log('ip address ${ipv6RegExp.hasMatch(value)}');
//       return 'Invalid Address';
//     } else {
//       return null;
//     }
//   }

//   String? validateText(String? value) {
//     if (value!.isEmpty) {
//       return 'champ requis';
//     }

//     return null;
//   }

//   String? validateReference(String? value) {
//     if (value!.isEmpty) {
//       return 'champ requis';
//     } else if (value.length < 10) {
//       return 'référence non conforme';
//     }

//     return null;
//   }

//   String? validatePayMode(PaymentMode? value) {
//     if (value == null) {
//       return 'Sélectionnez le mode de paiement.';
//     }
//     return null;
//   }

//   String? validateNum(String? value) {
//     String pattern = r'(^[0-9,\.]*$)';
//     RegExp regExp = RegExp(pattern);
//     if (value == null) {
//       return 'Champ requis';
//     } else if (!regExp.hasMatch(value)) {
//       return 'Montant non valide';
//     }
//     return null;
//   }
// }
