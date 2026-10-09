import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// One row of the items list.
class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: customColors.background,
      elevation: 1,
      child: ListTile(
        title: Text(
          item.name,
          style: context.textTheme.titleMedium?.copyWith(
            color: customColors.black1,
          ),
        ),
        subtitle: item.description == null
            ? null
            : Text(
                item.description!,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: customColors.surface,
                ),
              ),
      ),
    );
  }
}
