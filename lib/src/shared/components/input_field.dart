import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.inputFormatters,
      required this.validator,
      required this.keyboardType,
      this.style,
      this.onChanged,
      this.onTap,
      required this.labelText,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.controller,
      this.initialValue,
      this.prefixIcon,
      this.suffixIcon,
      this.labelColor,
      this.radius,
      this.maxlines,
      this.minlines,
      this.readOnly = false,
      this.enabled = true,
      this.hintText,
      this.padding,
      this.contentPadding,
      this.inputStyle,
      this.onEditingComplete});

  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? labelText;
  final bool obscureText;
  final bool enableSuggestions;
  final TextEditingController? controller;
  final String? initialValue;
  final Icon? prefixIcon;
  final Color? labelColor;

  final Widget? suffixIcon;
  final double? radius;
  final int? maxlines;

  final int? minlines;
  final bool? readOnly;
  final bool? enabled;
  final String? hintText;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;

  final TextStyle? inputStyle;
  final VoidCallback? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 12.0),
          child: Material(
            color: AppColors.white1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
            ),
            elevation: 10.0,
            shadowColor: AppColors.grey1.withValues(alpha: 0.2),
            child: TextFormField(
                onEditingComplete: onEditingComplete,
                enabled: enabled,
                onTap: onTap,
                readOnly: readOnly!,
                maxLines: maxlines ?? 1,
                minLines: minlines ?? 1,
                initialValue: initialValue,
                controller: controller,
                obscureText: obscureText,
                enableSuggestions: enableSuggestions,
                inputFormatters: inputFormatters,
                validator: validator,
                keyboardType: keyboardType,
                style: inputStyle ??
                    AppTheme.lightTextTheme.displaySmall!
                        .copyWith(color: AppColors.black1, fontSize: 14),
                onChanged: onChanged,
                decoration: customInputDecoration(labelText, prefixIcon,
                    suffixIcon, labelColor, radius, hintText, contentPadding)),
          ),
        ),
        // const Icon(
        //   Icons.email_rounded,
        //   color: AppColors.primary,
        // ),
      ],
    );
  }
}
