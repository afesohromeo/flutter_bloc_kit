import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// A reusable dropdown widget with loading states and dynamic content
///
/// Generic type [T] represents the data type of dropdown items
/// Generic type [S] represents the status enum type
class DynamicDropdown<T, S> extends StatelessWidget {
  // State management
  final S status;
  final S successStatus;
  final S loadingStatus;
  final S failureStatus;
  final List<T> items;
  final T? selectedValue;

  // Display properties
  final String Function(T) getDisplayText;
  final String labelText;
  final String successHintText;
  final String loadingText;
  final String failureText;
  final String noItemsText;

  // Callbacks
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  // Styling properties
  final double borderRadius;
  final double elevation;
  final Color? shadowColor;
  final Color? dropdownColor;
  final EdgeInsets contentPadding;
  final double iconSize;
  final double? menuMaxHeight;
  final double itemHeight;
  final InputDecoration? customDecoration;
  final Widget? customIcon;
  final bool isDense;
  final AlignmentGeometry alignment;

  const DynamicDropdown({
    super.key,

    // Required parameters
    required this.status,
    required this.successStatus,
    required this.loadingStatus,
    required this.failureStatus,
    required this.items,
    required this.selectedValue,
    required this.getDisplayText,
    required this.successHintText,
    required this.loadingText,
    required this.failureText,
    required this.noItemsText,
    required this.labelText,
    this.onChanged,
    this.validator,

    // Optional styling with defaults
    this.borderRadius = 30.0,
    this.elevation = 10.0,
    this.shadowColor,
    this.dropdownColor,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.iconSize = 25.0,
    this.menuMaxHeight,
    this.itemHeight = kMinInteractiveDimension,
    this.customDecoration,
    this.customIcon,
    this.isDense = true,
    this.alignment = AlignmentDirectional.topStart,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      elevation: elevation,
      shadowColor: shadowColor,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        disabledHint: Text(_getDisabledHint()),
        validator: validator,
        itemHeight: itemHeight,
        alignment: alignment,
        borderRadius: BorderRadius.circular(borderRadius),
        isDense: isDense,
        iconSize: iconSize,
        menuMaxHeight: menuMaxHeight ?? MediaQuery.sizeOf(context).height * 0.7,
        decoration: _buildDefaultDecoration(borderRadius, context),
        elevation: elevation.toInt(),
        dropdownColor: dropdownColor ?? customColors.background,
        icon: customIcon ?? const SizedBox(),
        value: status == loadingStatus ? null : selectedValue,
        items: _buildDropdownItems(),
        onChanged: status == loadingStatus ? null : onChanged,
      ),
    );
  }

  /// Build the default input decoration
  InputDecoration _buildDefaultDecoration(double radius, BuildContext context) {
    return customInputDecoration(
        labelText,
        null,
        Icon(Icons.keyboard_arrow_down_rounded),
        null,
        radius,
        null,
        null,
        context);
  }

  /// Determine hint text based on status
  // String _getHintText() {
  //   if (status == successStatus) {
  //     return items.isEmpty ? '' : successHintText;
  //   }
  //   return '';
  // }

  /// Determine disabled hint text
  String _getDisabledHint() {
    if (status == failureStatus) {
      return failureText;
    }
    return noItemsText;
  }

  /// Build dropdown items based on status
  List<DropdownMenuItem<T>> _buildDropdownItems() {
    if (status == loadingStatus) {
      return [
        DropdownMenuItem<T>(
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator.adaptive(),
              ),
              const SizedBox(width: 10),
              Text(loadingText),
            ],
          ),
        ),
      ];
    }

    return items
        .map((item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                getDisplayText(item),
                overflow: TextOverflow.ellipsis,
              ),
            ))
        .toList();
  }
}
