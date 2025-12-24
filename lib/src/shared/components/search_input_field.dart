import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField(
      {super.key,
      required this.onChanged,
      required this.labelText,
      this.padding,
      this.initialValue,
      this.inputController,
      this.labelColor,
      this.bgColor = AppColors.white1,
      this.showSuffixIcon = true,
      this.shape});
  final void Function(String)? onChanged;
  final String labelText;
  final EdgeInsets? padding;
  final String? initialValue;
  final TextEditingController? inputController;
  final Color? labelColor;
  final Color bgColor;
  final bool? showSuffixIcon;
  final ShapeBorder? shape;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveLayout.isMobile(context)
          ? null
          : MediaQuery.sizeOf(context).width * .4,
      child: InputField(
        borderRadius: BorderRadius.circular(10),
        labelColor: labelColor,
        bgColor: bgColor,
        controller: inputController,
        padding: padding ?? EdgeInsets.zero,
        validator: null,
        radius: 10,
        contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 12),

        // hintText: 'Recherche',
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        labelText: labelText,

        suffixIcon: showSuffixIcon!
            ? Icon(
                Icons.search_rounded,
                color: labelColor,
              )
            : null,
      ),
    );
  }
}
