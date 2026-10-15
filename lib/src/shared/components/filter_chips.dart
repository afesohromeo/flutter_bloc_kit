import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// One choice of [FilterChips] or [PickerPill].
class FilterChoice<T> {
  const FilterChoice(this.value, this.label);

  final T value;
  final String label;
}

/// A pill-shaped filter: filled in the primary colour when [selected],
/// white with a line otherwise.
class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  /// After the label, e.g. ▾ on a picker.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final foreground = selected ? customColors.background : customColors.black1;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? customColors.primary : customColors.background,
        shape: StadiumBorder(
          side: BorderSide(
            color: selected
                ? customColors.primary
                : customColors.surface.withValues(alpha: .5),
          ),
        ),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onTap,
          child: Container(
            height: 34,
            padding: EdgeInsets.only(left: 14, right: icon == null ? 14 : 8),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: foreground,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
                  ),
                ),
                if (icon case final icon?) ...[
                  const Gap.horizontal(width: 2),
                  Icon(icon, size: 18, color: foreground),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A row of filter pills, one chosen at a time, scrolling sideways when it
/// doesn't fit. [trailing] follows the pills, e.g. a
/// [PickerPill].
class FilterChips<T> extends StatelessWidget {
  const FilterChips({
    super.key,
    required this.choices,
    required this.selected,
    required this.onSelected,
    required this.keyPrefix,
    this.trailing = const [],
  });

  final List<FilterChoice<T>> choices;
  final T selected;
  final ValueChanged<T> onSelected;

  /// The pills are keyed `<keyPrefix>.<index>`.
  final String keyPrefix;
  final List<Widget> trailing;

  static Key chipKey(String keyPrefix, int index) => Key('$keyPrefix.$index');

  @override
  Widget build(BuildContext context) {
    final pills = [
      for (var i = 0; i < choices.length; i++)
        FilterPill(
          key: chipKey(keyPrefix, i),
          label: choices[i].label,
          selected: choices[i].value == selected,
          onTap: () {
            if (choices[i].value != selected) onSelected(choices[i].value);
          },
        ),
      ...trailing,
    ];
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < pills.length; i++) ...[
              if (i > 0) const Gap.horizontal(width: AppSpacing.sm),
              pills[i],
            ],
          ],
        ),
      ),
    );
  }
}

/// A pill that opens its [choices], e.g. "All stages ▾"; highlighted when
/// anything but the first choice is chosen.
class PickerPill<T> extends StatelessWidget {
  const PickerPill({
    super.key,
    required this.choices,
    required this.selected,
    required this.onSelected,
    required this.keyPrefix,
  });

  final List<FilterChoice<T>> choices;
  final T selected;
  final ValueChanged<T> onSelected;

  /// The pill is keyed `<keyPrefix>`, its choices `<keyPrefix>.<index>`.
  final String keyPrefix;

  static Key optionKey(String keyPrefix, int index) => Key('$keyPrefix.$index');

  @override
  Widget build(BuildContext context) {
    final index = choices.indexWhere((c) => c.value == selected);
    final current = index < 0 ? 0 : index;
    return PopupMenuButton<int>(
      key: Key(keyPrefix),
      tooltip: choices[current].label,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: customColors.background,
      surfaceTintColor: Colors.transparent,
      onSelected: (i) {
        if (i != current) onSelected(choices[i].value);
      },
      itemBuilder: (context) => [
        for (var i = 0; i < choices.length; i++)
          CheckedPopupMenuItem<int>(
            key: optionKey(keyPrefix, i),
            value: i,
            checked: i == current,
            child: Text(choices[i].label),
          ),
      ],
      child: IgnorePointer(
        child: FilterPill(
          label: choices[current].label,
          selected: current != 0,
          icon: Icons.expand_more_rounded,
          onTap: () {},
        ),
      ),
    );
  }
}
