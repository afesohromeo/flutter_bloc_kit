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
    this.elevation = 0,
    this.radius = 10,
    this.isRequired = false,
  });

  final TextEditingController? phoneNumberController;
  final OnPhoneNumberChanged? onChanged;
  final OnPhoneNumberChanged? onSaved;
  final String? initialCountryCode;
  final String? initialValue;
  final bool enabled;
  final BuildContext parentContext;
  final double elevation;
  final double radius;
  final bool isRequired;

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
    final l10n = AppLocalizations.of(widget.parentContext)!;
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
                    borderRadius: BorderRadius.circular(widget.radius),
                  ),
                  elevation: widget.elevation,
                  shadowColor: customColors.surface.withValues(alpha: 0.2),
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
                          //             customColors.error.withValues(alpha: .7),
                          //         content: Text(
                          //          l10n
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
                          countryNameStyle: context.textTheme.displayMedium!
                              .copyWith(fontSize: 14),
                          countryCodeStyle: context.textTheme.displayMedium!
                              .copyWith(
                                  fontSize: 14, color: customColors.black1),
                          searchFieldInputDecoration: customInputDecoration(
                              l10n.searchCountry,
                              null,
                              const Icon(Icons.search_rounded),
                              customColors.black1.withValues(alpha: .8),
                              widget.radius,
                              null,
                              null,
                              context),
                          listTileDivider: Divider(
                            color: customColors.surface,
                          ),
                        ),
                        flagsButtonMargin:
                            const EdgeInsets.fromLTRB(12, 0, 0, 0),
                        controller: widget.phoneNumberController,
                        initialValue: widget.initialValue,
                        invalidNumberMessage: l10n.validateMobile1,
                        flagsButtonPadding:
                            const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        style: context.textTheme.displaySmall!
                            .copyWith(color: customColors.black1, fontSize: 14),
                        dropdownTextStyle: context.textTheme.displayMedium!
                            .copyWith(fontSize: 14),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.radius),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              customColors.background,
                              customColors.background,
                            ],
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        disableLengthCheck: true,
                        dropdownIconPosition: IconPosition.trailing,
                        autovalidateMode: AutovalidateMode.disabled,
                        decoration: customInputDecoration(
                            l10n.tel,
                            null,
                            null,
                            customColors.black1.withValues(alpha: .8),
                            widget.radius,
                            null,
                            null,
                            context),
                        initialCountryCode: widget.initialCountryCode,
                        onChanged: (phone) {
                          if (_validateAsUserTypes) {
                            _validatePhoneNumber(phone.number, l10n);
                          }
                          widget.onChanged?.call(phone);
                          state.didChange(phone.number);
                        },
                        onSaved: (phone) {
                          widget.onSaved?.call(phone);
                        },
                      ),
                      // Overlay to disable dropdown functionality
                      Positioned.fill(
                        child: Row(
                          children: [
                            AbsorbPointer(
                              absorbing: true,
                              child: SizedBox(
                                width: 120, // adjust slightly if needed
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
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
          validator: widget.isRequired
              ? (value) {
                  log('submit $value'); // Always validate during submission
                  final error = _validatePhoneNumber(
                      value ?? widget.phoneNumberController?.text, l10n);

                  if (error != null) {
                    // Enable dynamic validation for subsequent typing
                    setState(() {
                      _validateAsUserTypes = true;
                    });
                  }

                  return error;
                }
              : null,
        );
      },
    );
  }

  String? _validatePhoneNumber(String? value, AppLocalizations l10n) {
    if (value == null || value.isEmpty) {
      final error = l10n.validateMobile1;
      _errorNotifier.value = error;
      return error;
    }
    // Ensure the number starts with '6'
    if (!value.startsWith('6')) {
      final error = l10n.validateMobile2;
      _errorNotifier.value = error;
      return error;
    }

    String? validationError;

    // Set error and return if validation fails
    _errorNotifier.value = validationError;
    return validationError;
  }
}

typedef OnPhoneNumberChanged = void Function(PhoneNumber?);
