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
  final VoidCallback? onRetry;

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
  final double? height;

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
    this.onRetry,

    // Optional styling with defaults
    this.borderRadius = 30.0,
    this.elevation = 10.0,
    this.shadowColor,
    this.dropdownColor,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    this.iconSize = 25.0,
    this.menuMaxHeight,
    this.itemHeight = kMinInteractiveDimension,
    this.customDecoration,
    this.customIcon,
    this.isDense = true,
    this.alignment = AlignmentDirectional.topStart,
    this.height = 37,
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
        isDense: true,
        iconSize: iconSize,
        menuMaxHeight: menuMaxHeight ?? MediaQuery.sizeOf(context).height * 0.7,
        decoration: _buildDefaultDecoration(borderRadius, context),
        elevation: elevation.toInt(),
        dropdownColor: dropdownColor ?? customColors.secondary,
        icon: customIcon ?? _buildIcon(),
        initialValue: status == loadingStatus ? null : selectedValue,
        items: _buildDropdownItems(context),
        onChanged: status == loadingStatus ? null : onChanged,
      ),
    );
  }

  Widget _buildIcon() {
    final bool showRetry =
        status == failureStatus || (status == successStatus && items.isEmpty);

    if (showRetry) {
      return IconButton(
        icon: Icon(Icons.refresh_rounded, color: Colors.red, size: iconSize),
        onPressed: onRetry,
      );
    }

    return Icon(
      Icons.keyboard_arrow_down_rounded,
      size: iconSize,
      color: customColors.black1,
    );
  }

  /// Build the default input decoration
  InputDecoration _buildDefaultDecoration(double radius, BuildContext context) {
    return customInputDecoration(
      labelText,
      null,
      Icon(Icons.keyboard_arrow_down_rounded, color: customColors.black1),
      customColors.black1.withValues(alpha: .8),
      radius,
      null,
      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      context,
    );
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
  List<DropdownMenuItem<T>> _buildDropdownItems(BuildContext context) {
    if (status == loadingStatus) {
      return [
        DropdownMenuItem<T>(
          child: Row(
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              ),
              const SizedBox(width: 10),
              Flexible(child: Text(loadingText)),
            ],
          ),
        ),
      ];
    }

    return items
        .map(
          (item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              getDisplayText(item),
              style: context.textTheme.displaySmall!.copyWith(
                color: customColors.black1.withValues(alpha: .8),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
        .toList();
  }
}
