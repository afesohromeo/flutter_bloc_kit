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
                textColor: AppColors.black1,
                iconColor: AppColors.grey1,
                selected: selected,
                enabled: enabled,
                selectedColor: AppColors.white1,
                selectedTileColor: AppColors.primary,
                tileColor: Colors.transparent,
                splashColor: AppColors.primary.withValues(alpha: .3),
                title: Text(
                  title,
                  style: AppTheme.lightTextTheme.displayMedium!.copyWith(
                      color: selected
                          ? AppColors.white1
                          : (!enabled || onTap == null)
                              ? AppColors.grey3
                              : AppColors.black1),
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
