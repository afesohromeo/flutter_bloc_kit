import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// One part of a [Breadcrumb]; the last part has no [onTap].
class BreadcrumbItem {
  const BreadcrumbItem(this.label, {this.onTap});

  final String label;
  final VoidCallback? onTap;
}

/// Where the page sits: "Projects › Maison Douala › Stages › Walls"
///. Every part but the last opens its page. When the line
/// doesn't fit, the middle parts fold into "…", keeping the first and the
/// last two.
class Breadcrumb extends StatelessWidget {
  const Breadcrumb({super.key, required this.items});

  final List<BreadcrumbItem> items;

  static Key partKey(int index) => Key('breadcrumb.$index');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final link = context.textTheme.bodySmall?.copyWith(
      color: customColors.primary,
      fontWeight: FontWeight.w700,
    );
    final current = context.textTheme.bodySmall?.copyWith(
      color: customColors.black1,
      fontWeight: FontWeight.w600,
    );

    Widget part(int index, {bool last = false}) {
      final item = items[index];
      final text = Text(
        item.label,
        key: partKey(index),
        style: last ? current : link,
        overflow: TextOverflow.ellipsis,
      );
      if (last || item.onTap == null) return Flexible(child: text);
      return Flexible(
        child: InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: text,
          ),
        ),
      );
    }

    final separator = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text('›', style: context.textTheme.bodySmall),
    );

    return Semantics(
      container: true,
      label: l10n.breadcrumbLabel,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Roughly what fits: about 7 px a character plus the separators.
          final full =
              items.fold<int>(0, (n, i) => n + i.label.length) * 7 +
              items.length * 20;
          final fold = items.length > 3 && full > constraints.maxWidth;
          final shown = fold
              ? [0, items.length - 2, items.length - 1]
              : [for (var i = 0; i < items.length; i++) i];

          final children = <Widget>[];
          for (var k = 0; k < shown.length; k++) {
            if (k > 0) children.add(separator);
            if (fold && k == 1) {
              children
                ..add(Text('…', style: context.textTheme.bodySmall))
                ..add(separator);
            }
            children.add(part(shown[k], last: k == shown.length - 1));
          }
          return Row(children: children);
        },
      ),
    );
  }
}
