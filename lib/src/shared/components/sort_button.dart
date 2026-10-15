import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// An icon that opens the ways a list can be ordered, the current one
/// checked.
class SortButton<T> extends StatelessWidget {
  const SortButton({
    super.key,
    required this.choices,
    required this.selected,
    required this.onSelected,
  });

  final List<FilterChoice<T>> choices;
  final T selected;
  final ValueChanged<T> onSelected;

  static const buttonKey = Key('sort.button');
  static Key optionKey(int index) => Key('sort.$index');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<int>(
      key: buttonKey,
      tooltip: l10n.sortAction,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: customColors.background,
      surfaceTintColor: Colors.transparent,
      onSelected: (i) {
        if (choices[i].value != selected) onSelected(choices[i].value);
      },
      itemBuilder: (context) => [
        for (var i = 0; i < choices.length; i++)
          CheckedPopupMenuItem<int>(
            key: optionKey(i),
            value: i,
            checked: choices[i].value == selected,
            child: Text(choices[i].label),
          ),
      ],
      child: Container(
        width: 48,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: customColors.background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: customColors.surface.withValues(alpha: .5)),
        ),
        child: Icon(Icons.swap_vert_rounded, color: customColors.black1),
      ),
    );
  }
}
