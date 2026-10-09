import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter/material.dart';

class MultiSelectField<T> extends StatelessWidget {
  const MultiSelectField({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChanged,
    required this.getDisplayText,
    required this.labelText,
    this.dialogTitle,
    this.borderRadius = 10.0,
    this.elevation = 0.0,
    this.validator,
  });

  final List<T> items;
  final List<T> selectedValues;
  final ValueChanged<List<T>> onChanged;
  final String Function(T) getDisplayText;
  final String labelText;
  final String? dialogTitle;
  final double borderRadius;
  final double elevation;
  final FormFieldValidator<List<T>>? validator;

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedValues.isNotEmpty;

    return FormField<List<T>>(
      validator: (_) => validator?.call(selectedValues),
      builder: (formState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                side: BorderSide.none,
              ),
              elevation: elevation,
              shadowColor: Colors.transparent,
              child: GestureDetector(
                onTap: () => _showPickerDialog(context),
                child: InputDecorator(
                  decoration: customInputDecoration(
                    labelText,
                    null,
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: customColors.black1,
                    ),
                    customColors.black1.withValues(alpha: .8),
                    borderRadius,
                    null,
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    context,
                    visualDensity: VisualDensity(
                      vertical: -2.7,
                      horizontal: -4,
                    ),
                  ),
                  isEmpty: !hasSelection,
                  child: hasSelection
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            selectedValues.map(getDisplayText).join(', '),
                            style: context.textTheme.displaySmall?.copyWith(
                              fontSize: 14,
                              color: customColors.black1.withValues(alpha: .8),
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            if (formState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 12),
                child: Text(
                  formState.errorText!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: customColors.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showPickerDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var tempSelected = List<T>.from(selectedValues);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: customColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              dialogTitle ?? labelText,
              style: context.textTheme.displayMedium?.copyWith(
                color: customColors.black1,
                fontSize: 14,
              ),
            ),
            content: SizedBox(
              width: 280,
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        l10n.noData,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: customColors.black1.withValues(alpha: .6),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        final isSelected = tempSelected.contains(item);
                        return CheckboxListTile(
                          dense: true,
                          value: isSelected,
                          title: Text(
                            getDisplayText(item),
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: customColors.black1,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (checked) {
                            setDialogState(() {
                              if (checked == true) {
                                if (!isSelected) {
                                  tempSelected = [...tempSelected, item];
                                }
                              } else {
                                tempSelected = tempSelected
                                    .where((e) => e != item)
                                    .toList();
                              }
                            });
                          },
                        );
                      },
                    ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  l10n.cancel,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: customColors.black1,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  onChanged(tempSelected);
                  Navigator.of(context).pop();
                },
                child: Text(
                  l10n.ok,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: customColors.black1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
