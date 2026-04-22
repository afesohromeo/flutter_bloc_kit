import 'dart:developer';

import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef SearchableDropdownItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
);

/// A simple searchable dropdown field for local list selection.
///
/// Designed for cases such as selecting employees from a large in-memory list.
class SearchableDropdownField<T> extends StatefulWidget {
  const SearchableDropdownField({
    super.key,
    required this.items,
    this.selectedValue,
    required this.itemToString,
    this.itemBuilder,
    required this.onChanged,
    this.validator,
    this.onRetry,
    this.labelText,
    this.hintText,
    this.searchHintText,
    this.noItemsText,
    this.loadingText,
    this.failureText,
    this.isLoading = false,
    this.isFailure = false,
    this.enabled = true,
    this.borderRadius = 10.0,
    this.fillColor,
    this.borderColor,
    this.margin,
  });

  final List<T> items;
  final T? selectedValue;
  final String Function(T) itemToString;
  final SearchableDropdownItemBuilder<T>? itemBuilder;

  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final VoidCallback? onRetry;

  final String? labelText;
  final String? hintText;
  final String? searchHintText;
  final String? noItemsText;
  final String? loadingText;
  final String? failureText;

  final bool isLoading;
  final bool isFailure;
  final bool enabled;

  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;

  @override
  State<SearchableDropdownField<T>> createState() =>
      _SearchableDropdownFieldState<T>();
}

class _SearchableDropdownFieldState<T>
    extends State<SearchableDropdownField<T>> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _syncText();
  }

  @override
  void didUpdateWidget(SearchableDropdownField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      _syncText();
    }
  }

  void _syncText() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final selectedValue = widget.selectedValue;
      _controller.text =
          selectedValue == null ? '' : widget.itemToString(selectedValue);
    });
  }

  void _clearField() {
    _controller.clear();
    widget.onChanged(null);
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();

    super.dispose();
  }

  List<T> get _filteredItems {
    final search = _searchController.text.toLowerCase();
    log('filteringg $search ,, ');

    return widget.items.where((item) {
      if (search.isEmpty) return true;
      final query = search.toLowerCase();

      return widget.itemToString(item).toLowerCase().contains(query);
    }).toList();
  }

  Future<T?> _openSelectionDialog(
      T? selectedValue, AppLocalizations l10n) async {
    if (!widget.enabled || widget.isLoading || widget.isFailure) return null;

    final chosen = await showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
        ),
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setModalState) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 12,
                  left: 16,
                  right: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchInputField(
                      inputController: _searchController,
                      onChanged: (_) {
                        setModalState(() {}); // 🔥 THIS is the fix
                      },
                      labelText: l10n.search,
                      showSuffixIcon: false,
                      bgColor: customColors.surface,
                      labelColor: customColors.black1.withValues(alpha: .7),
                    ),
                    const SizedBox(height: 8),
                    if (_filteredItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(widget.noItemsText ?? l10n.noData),
                      )
                    else
                      Flexible(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _filteredItems.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            return ListTile(
                              title: widget.itemBuilder?.call(context, item) ??
                                  Text(
                                    widget.itemToString(item),
                                    style: context.textTheme.displaySmall!
                                        .copyWith(
                                            color: customColors.black1
                                                .withValues(alpha: .8),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 14),
                                  ),
                              selected: item == selectedValue,
                              onTap: () {
                                context.pop(item);
                              },
                            );
                          },
                        ),
                      )
                  ],
                ),
              );
            },
          );
        });

    return chosen;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final hasFilled = widget.selectedValue != null;

    return InputField(
      onTap: () async {
        final result = await _openSelectionDialog(widget.selectedValue, l10n);
        widget.onChanged(result);
      },
      readOnly: true,
      // hintText: _getHintText(l10n),
      visualDensity: VisualDensity(vertical: -2.8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      labelText: _getHintText(l10n),
      controller: _controller,
      validator: widget.validator == null
          ? null
          : (_) => widget.validator!(widget.selectedValue),
      keyboardType: TextInputType.text,
      radius: 10,
      enableSuggestions: true,
      obscureText: false,
      padding: EdgeInsets.zero,
      labelColor: customColors.black1.withValues(alpha: .8),
      suffixIcon: widget.isLoading
          ? CircularProgressIndicator.adaptive(
              padding: EdgeInsets.all(10),
              strokeWidth: 2,
            )
          : widget.isFailure
              ? IconButton(
                  icon:
                      Icon(Icons.refresh_rounded, color: Colors.red, size: 20),
                  onPressed: widget.onRetry,
                )
              : hasFilled
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _clearField,
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: customColors.black1.withValues(alpha: .8),
                      ),
                    )
                  : Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: customColors.black1,
                    ),
    );
  }

  String _getHintText(AppLocalizations l10n) {
    if (widget.isLoading) {
      return widget.loadingText ?? l10n.loading;
    }

    if (widget.isFailure) {
      return widget.failureText ?? l10n.operationError;
    } else {
      return widget.labelText ?? '';
    }
  }

  // Widget _statusWidget({required Widget child}) {
  //   return Container(
  //     margin: widget.margin,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(widget.borderRadius),
  //       color: widget.fillColor ?? customColors.surface,
  //       border: Border.all(
  //         color:
  //             widget.borderColor ?? customColors.black1.withValues(alpha: .15),
  //       ),
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  //     child: child,
  //   );
  // }
}
