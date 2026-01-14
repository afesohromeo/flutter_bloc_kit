import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile(
      {super.key,
      required this.title,
      this.iconData,
      required this.onTap,
      this.selected = false,
      required this.isVisible});

  final String title;
  final IconData? iconData;
  final VoidCallback? onTap;
  final bool selected;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap == null ? false : true;
    return isVisible
        ? Column(
            children: [
              ListTile(
                textColor: customColors.black1,
                iconColor: customColors.surface,
                selected: selected,
                enabled: enabled,
                selectedColor: customColors.background,
                selectedTileColor: customColors.primary,
                tileColor: Colors.transparent,
                splashColor: customColors.primary.withValues(alpha: .3),
                title: Text(
                  title,
                  style: context.textTheme.displayMedium!.copyWith(
                      color: selected
                          ? customColors.background
                          : (!enabled || onTap == null)
                              ? customColors.surface
                              : customColors.black1),
                ),
                leading: iconData == null
                    ? null
                    : Icon(
                        iconData,
                        size: 20,
                      ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                onTap: onTap,
                style: ListTileStyle.list,
              ),
              const Gap.vertical(
                height: 10,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
