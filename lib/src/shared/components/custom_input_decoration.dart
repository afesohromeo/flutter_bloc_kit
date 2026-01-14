import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

InputDecoration customInputDecoration(
    String? labelText,
    Icon? prefixIcon,
    Widget? suffixIcon,
    Color? labelColor,
    double? radius,
    String? hintText,
    EdgeInsets? contentPadding,
    BuildContext context,
    {FloatingLabelAlignment alignment = FloatingLabelAlignment.start,
    Color? bgColor,
    BorderRadius? borderRadius}) {
  return InputDecoration(
    // counterStyle: context.textTheme.displayMedium!.copyWith(fontSize: 29),
    contentPadding: contentPadding ?? const EdgeInsets.all(12),

    // isCollapsed: true,

    // prefixIcon: prefixIcon,
    // prefix: const Icon(
    //   Icons.email_outlined,
    //   color: customColors.primary,
    //   size: 12,
    // ),

    hintText: hintText,
    hintStyle: context.textTheme.bodyMedium?.copyWith(
      color: customColors.surface,
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    fillColor: bgColor ?? customColors.background,
    filled: true,
    labelText: labelText,
    labelStyle: context.textTheme.displayMedium!.copyWith(
      fontSize: 14,
      color: labelColor ?? customColors.surface,
    ),
    floatingLabelAlignment: alignment,
    floatingLabelStyle: context.textTheme.displayMedium!
        .copyWith(color: labelColor ?? customColors.surface, fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 10),
      borderSide:
          BorderSide(color: labelColor ?? customColors.surface, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
      borderSide: BorderSide(
          color: labelColor ?? customColors.surface.withValues(alpha: .5),
          width: 1),
    ),
    // focusColor: Color.fromARGB(255, 185, 61, 24),
    // enabledBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(color: labelColor ?? customColors.primary),
    // ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
      borderSide:
          BorderSide(color: labelColor ?? customColors.primary, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 10),
      borderSide:
          BorderSide(color: labelColor ?? customColors.surface, width: 1),
    ),
    errorMaxLines: 2,
    errorStyle: context.textTheme.bodyMedium!
        .copyWith(color: customColors.error, fontSize: 12),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 10),
      borderSide:
          BorderSide(color: labelColor ?? customColors.primary, width: 1),
    ),
  );
}
