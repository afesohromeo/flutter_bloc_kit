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
    {FloatingLabelAlignment alignment = FloatingLabelAlignment.start,
    Color bgColor = AppColors.white1,
    BorderRadius? borderRadius}) {
  return InputDecoration(
    // counterStyle: AppTextTheme.light.displayMedium!.copyWith(fontSize: 29),
    contentPadding: contentPadding ?? const EdgeInsets.all(12),

    // isCollapsed: true,

    // prefixIcon: prefixIcon,
    // prefix: const Icon(
    //   Icons.email_outlined,
    //   color: AppColors.primary,
    //   size: 12,
    // ),

    hintText: hintText,
    hintStyle: AppTextTheme.light.bodyMedium?.copyWith(
      color: AppColors.grey3,
    ),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    fillColor: bgColor,
    filled: true,
    labelText: labelText,
    labelStyle: AppTextTheme.light.displayMedium!.copyWith(
      fontSize: 14,
      color: labelColor ?? AppColors.grey,
    ),
    floatingLabelAlignment: alignment,
    floatingLabelStyle: AppTextTheme.light.displayMedium!
        .copyWith(color: labelColor ?? AppColors.grey, fontSize: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 10),
      borderSide: BorderSide(color: labelColor ?? AppColors.grey, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
      borderSide: BorderSide(
          color: labelColor ?? AppColors.grey.withValues(alpha: .5), width: 1),
    ),
    // focusColor: Color.fromARGB(255, 185, 61, 24),
    // enabledBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(color: labelColor ?? AppColors.primary),
    // ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 10),
      borderSide: BorderSide(color: labelColor ?? AppColors.primary, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 10),
      borderSide: BorderSide(color: labelColor ?? AppColors.grey2, width: 1),
    ),
    errorMaxLines: 2,
    errorStyle: AppTextTheme.light.bodyMedium!
        .copyWith(color: AppColors.error, fontSize: 12),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius ?? 10),
      borderSide: BorderSide(color: labelColor ?? AppColors.primary, width: 1),
    ),
  );
}
