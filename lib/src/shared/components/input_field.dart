import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.inputFormatters,
      required this.validator,
      this.keyboardType,
      this.style,
      this.onChanged,
      this.onTap,
      this.labelText,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.controller,
      this.initialValue,
      this.prefixIcon,
      this.suffixIcon,
      this.labelColor,
      this.bgColor,
      this.radius,
      this.maxlines,
      this.minlines,
      this.readOnly = false,
      this.enabled = true,
      this.hintText,
      this.padding,
      this.contentPadding,
      this.inputStyle,
      this.onEditingComplete,
      this.elevation = 0,
      this.focusNode,
      this.borderRadius});

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
  final Color? bgColor;

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
  final double elevation;
  final FocusNode? focusNode;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
          child: Material(
            color: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
            ),
            elevation: elevation,
            shadowColor: customColors.surface.withValues(alpha: 0.2),
            child: TextFormField(
                focusNode: focusNode,
                onEditingComplete: onEditingComplete,
                enabled: enabled,
                onTap: onTap,
                readOnly: readOnly!,
                maxLines: maxlines ?? 1,
                initialValue: initialValue,
                controller: controller,
                obscureText: obscureText,
                enableSuggestions: enableSuggestions,
                inputFormatters: inputFormatters,
                validator: validator,
                keyboardType: keyboardType,
                style: inputStyle ??
                    context.textTheme.displaySmall!.copyWith(
                        color: labelColor ?? customColors.black1, fontSize: 14),
                onChanged: onChanged,
                decoration: customInputDecoration(
                    labelText,
                    prefixIcon,
                    borderRadius: borderRadius,
                    suffixIcon,
                    labelColor,
                    radius,
                    hintText,
                    contentPadding,
                    context,
                    bgColor: bgColor)),
          ),
        ),
        // const Icon(
        //   Icons.email_rounded,
        //   color: customColors.primary,
        // ),
      ],
    );
  }
}
