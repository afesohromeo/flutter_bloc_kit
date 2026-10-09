import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// Pre-styled search box. Debounce [onChanged] in the page or BLoC
/// (_standards/06, 02). With [onSuffixPressed], the search icon becomes a
/// button (e.g. to search on tap instead of while typing).
class SearchInputField extends StatelessWidget {
  const SearchInputField({
    super.key,
    required this.onChanged,
    required this.labelText,
    this.padding,
    this.initialValue,
    this.inputController,
    this.labelColor,
    this.bgColor,
    this.showSuffixIcon = true,
    this.shape,
    this.focusNode,
    this.onEditingComplete,
    this.onSuffixPressed,
  });

  final void Function(String)? onChanged;
  final String labelText;
  final EdgeInsets? padding;
  final String? initialValue;
  final TextEditingController? inputController;
  final Color? labelColor;
  final Color? bgColor;
  final bool? showSuffixIcon;
  final ShapeBorder? shape;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onSuffixPressed;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(Icons.search_rounded, color: labelColor);

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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        initialValue: initialValue,
        onChanged: onChanged,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        keyboardType: TextInputType.text,
        labelText: labelText,
        suffixIcon: !showSuffixIcon!
            ? null
            : onSuffixPressed == null
            ? icon
            : IconButton(icon: icon, onPressed: onSuffixPressed),
      ),
    );
  }
}
