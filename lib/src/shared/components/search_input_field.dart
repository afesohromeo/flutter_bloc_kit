import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField(
      {super.key,
      required this.onChanged,
      required this.labelText,
      this.padding,
      this.initialValue,
      this.inputController});
  final void Function(String)? onChanged;
  final String labelText;
  final EdgeInsets? padding;
  final String? initialValue;
  final TextEditingController? inputController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveLayout.isMobile(context)
          ? null
          : MediaQuery.sizeOf(context).width * .4,
      child: InputField(
        controller: inputController,
        padding: padding ?? EdgeInsets.zero,
        validator: null,
        radius: 50,
        // hintText: 'Recherche',
        initialValue: initialValue,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        labelText: labelText,
        suffixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.black1.withValues(alpha: .7),
        ),
      ),
    );
  }
}
