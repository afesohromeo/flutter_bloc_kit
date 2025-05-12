import 'dart:developer';


import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneNumberFormField extends StatefulWidget {
  const PhoneNumberFormField({
    super.key,
    this.phoneNumberController,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.initialCountryCode,
    this.enabled = true,
    required this.parentContext,
  });

  final TextEditingController? phoneNumberController;
  final OnPhoneNumberChanged? onChanged;
  final OnPhoneNumberChanged? onSaved;
  final String? initialCountryCode;
  final String? initialValue;
  final bool enabled;
  final BuildContext parentContext;

  @override
  State<PhoneNumberFormField> createState() => _PhoneNumberFormFieldState();
}

class _PhoneNumberFormFieldState extends State<PhoneNumberFormField> {
  final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);
  bool _validateAsUserTypes = false;

  @override
  void dispose() {
    _errorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _errorNotifier,
      builder: (context, errorText, child) {
        return FormField<String>(
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 10.0,
                  shadowColor: AppColors.secondary.withValues(alpha: 0.3),
                  child: Stack(
                    children: [
                      IntlPhoneField(
                        onCountryChanged: null,
                        readOnly: !widget.enabled,
                        onTap: () {
                          // if (!widget.enabled) {
                          //   ScaffoldMessenger.of(context)
                          //     ..clearSnackBars()
                          //     ..showSnackBar(
                          //       SnackBar(
                          //         duration: const Duration(seconds: 3),
                          //         backgroundColor:
                          //             AppColors.error.withValues(alpha: .7),
                          //         content: Text(
                          //           AppLocalizations.of(widget.parentContext)!
                          //               .selectPayMethod,
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .titleLarge!
                          //               .copyWith(fontSize: 15),
                          //         ),
                          //       ),
                          //     );
                          // }
                        },
                        pickerDialogStyle: PickerDialogStyle(
                          width: MediaQuery.of(context).size.width * .8,
                          countryNameStyle: AppTheme
                              .lightTextTheme.displayMedium!
                              .copyWith(fontSize: 14),
                          countryCodeStyle: AppTheme
                              .lightTextTheme.displayMedium!
                              .copyWith(fontSize: 14, color: AppColors.black1),
                          searchFieldInputDecoration: customInputDecoration(
                            AppLocalizations.of(widget.parentContext)!
                                .searchCountry,
                            null,
                            const Icon(Icons.search_rounded),
                            null,
                            50,
                            null,
                            null,
                          ),
                          listTileDivider: const Divider(
                            color: AppColors.grey1,
                          ),
                        ),
                        flagsButtonMargin:
                            const EdgeInsets.fromLTRB(.7, 0, 8, 0),
                        controller: widget.phoneNumberController,
                        initialValue: widget.initialValue,
                        invalidNumberMessage:
                            AppLocalizations.of(widget.parentContext)!
                                .validateMobile1,
                        flagsButtonPadding: const EdgeInsets.only(left: 10),
                        style: AppTheme.lightTextTheme.displaySmall!
                            .copyWith(color: AppColors.black1, fontSize: 14),
                        dropdownTextStyle: AppTheme
                            .lightTextTheme.displayMedium!
                            .copyWith(fontSize: 14),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              AppColors.white2,
                              AppColors.cardBg,
                            ],
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        disableLengthCheck: true,
                        dropdownIconPosition: IconPosition.trailing,
                        autovalidateMode: AutovalidateMode.disabled,
                        decoration: customInputDecoration(
                          AppLocalizations.of(widget.parentContext)!.tel,
                          null,
                          null,
                          null,
                          50,
                          null,
                          null,
                        ),
                        initialCountryCode: widget.initialCountryCode,
                        onChanged: (phone) {
                          if (_validateAsUserTypes) {
                            _validatePhoneNumber(phone.number);
                          }
                          widget.onChanged?.call(phone);
                          state.didChange(phone.number);
                        },
                        onSaved: (phone) {
                          widget.onSaved?.call(phone);
                        },
                      ),
                      // Overlay to disable dropdown functionality
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        width:
                            120, // Adjust based on the country selector width
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: null,
                            child: IgnorePointer(
                              ignoring:
                                  true, // Blocks interaction with the country selector
                              child: Container(
                                color: Colors.transparent, // Invisible overlay
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                if (errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          },
          validator: (value) {
            log('submit $value'); // Always validate during submission
            final error = _validatePhoneNumber(
                value ?? widget.phoneNumberController?.text);

            if (error != null) {
              // Enable dynamic validation for subsequent typing
              setState(() {
                _validateAsUserTypes = true;
              });
            }

            return error;
          },
        );
      },
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      final error = AppLocalizations.of(widget.parentContext)!.validateMobile1;
      _errorNotifier.value = error;
      return error;
    }
    // Ensure the number starts with '6'
    if (!value.startsWith('6')) {
      final error = AppLocalizations.of(widget.parentContext)!.validateMobile2;
      _errorNotifier.value = error;
      return error;
    }

    // Assuming `selectedPaymentMode` is a variable that holds the current payment mode
    // Replace this with actual logic to get the payment mode

    String? validationError;

    // switch (widget.selectedPaymentMode!.code!) {
    //   case 'MTN':
    //     {
    //       validationError = _validateMtnNumber(value);
    //       break;
    //     }
    //   case 'ORANGE':
    //     {
    //       validationError = _validateOrangeNumber(value);
    //       break;
    //     }

    //   default:
    //     {
    //       validationError = AppLocalizations.of(widget.parentContext)!.invalidPaymentMode;
    //       break;
    //     }
    // }

    // Set error and return if validation fails
    _errorNotifier.value = validationError;
    return validationError;
  }

// MTN-specific validation
  // String? _validateMtnNumber(String value) {
  //   final mtnRegex = RegExp(r'^(67\d{7}|65[0-4]\d{6}|68[0-4]\d{6})$');

  //   if (!mtnRegex.hasMatch(value)) {
  //     return AppLocalizations.of(widget.parentContext)!.invalidMtnNumber;
  //   }
  //   return null;
  // }

// Orange-specific validation
  // String? _validateOrangeNumber(String value) {
  //   final orangeRegex =
  //       RegExp(r'^(69\d{7}|64\d{7}|65[5-9]\d{6}|68[5-9]\d{6})$');

  //   if (!orangeRegex.hasMatch(value)) {
  //     return AppLocalizations.of(widget.parentContext)!.invalidOrangeNumber;
  //   }
  //   return null;
  // }
}

typedef OnPhoneNumberChanged = void Function(PhoneNumber?);
