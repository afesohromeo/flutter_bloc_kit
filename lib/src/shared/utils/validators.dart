

class Validators {
  Validators();

  String? password;

  // String? validateIndex(String? value) {
  //   // String pattern = r'^[a-z0-9,\.]+\-?[0-9a-z]+$';
  //   // RegExp regExp = RegExp(pattern);
  //   if (value!.isEmpty) {
  //     return 'Please insert index';
  //   } else if (value.length < 5) {
  //     return 'Invalid index';
  //   } else {
  //     return null;
  //   }
  // }
  // String? validatePrice(String? value, double minPrice) {
  //   try {
  //     log('validation begin $value ,, $minPrice');

  //     if (value == null || value.trim().isEmpty) {
  //       log('validation null or empty');
  //       return LocalizationService.localization.enterAmount;
  //     }

  //     final parsedAmount = double.tryParse(value);
  //     if (parsedAmount == null) {
  //       log('validation invalid amount');
  //       return LocalizationService.localization.invalidAmount;
  //     }

  //     if (parsedAmount < minPrice) {
  //       log('validation less than min');
  //       return '${LocalizationService.localization.invalidAmount2} ($minPrice)';
  //     }

  //     return null; // valid input
  //   } catch (e) {
  //     log('validation error $e');
  //   }
  //   log('validation none');
  //   return null;
  // }

  // String? validateText(String? value) {
  //   if (value!.isEmpty) {
  //     return LocalizationService.localization.required;
  //   }

  //   return null;
  // }

  // // String? validateReference(String? value) {
  // //   if (value!.isEmpty) {
  // //     return LocalizationService.localization.required;
  // //   } else if (value.length < 10) {
  // //     return 'référence non conforme';
  // //   }
  // //   return null;
  // // }

  // String? validateCaisse(Caisse? value) {
  //   if (value == null) {
  //     return LocalizationService.localization.selectCaise;
  //   }
  //   return null;
  // }

  // String? validateCaissier(Caissier? value) {
  //   if (value == null) {
  //     return LocalizationService.localization.selectCaisier;
  //   }
  //   return null;
  // }

  // String? validateAmount(String? value) {
  //   // double initialAmount = context.read<PaymentBloc>().state.amount;
  //   if (value == null || value.isEmpty) {
  //     return LocalizationService.localization.validateAmount1;
  //   }
  //   return null;
  // }

  // String? validateName(String? value) {
  //   if (value!.isEmpty) {
  //     return LocalizationService.localization.validateName;
  //   }

  //   return null;
  // }

  // String? validateClientName(String? value) {
  //   if (value!.isEmpty) {
  //     return LocalizationService.localization.validateName;
  //   }

  //   return null;
  // }

  // String? validateEmail(String? value) {
  //   String pattern =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = RegExp(pattern);
  //   if (value!.isEmpty) {
  //     return LocalizationService.localization.validateEmail1;
  //   } else if (!regExp.hasMatch(value)) {
  //     return LocalizationService.localization.validateEmail2;
  //   } else {
  //     return null;
  //   }
  // }
}
