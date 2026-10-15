import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

/// The scrolling body of a redrawn page: padded, centred, at
/// most [maxWidth] wide, with pull-to-refresh when [onRefresh] is given.
/// Wide enough (≥ [twoColumnsFrom]) and with a [side], it shows two columns:
/// [main] on the left, [side] on the right; otherwise one, [side]
/// below [main].
class ContentLayout extends StatelessWidget {
  const ContentLayout({
    super.key,
    required this.main,
    this.side = const [],
    this.onRefresh,
    this.maxWidth = 1200,
    this.twoColumnsFrom = 840,
    this.sideFlex = 2,
    this.sideLabels,
  });

  final List<Widget> main;
  final List<Widget> side;
  final Future<void> Function()? onRefresh;
  final double maxWidth;
  final double twoColumnsFrom;

  /// The side column's share against the main column's 3.
  final int sideFlex;

  /// One label per [side] item: in one column they become a segmented
  /// switch instead of a column of cards.
  final List<String>? sideLabels;

  static Widget _column(List<Widget> children) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0) const Gap.vertical(height: 14),
        children[i],
      ],
    ],
  );

  @override
  Widget build(BuildContext context) {
    final body = LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns =
            side.isNotEmpty && constraints.maxWidth >= twoColumnsFrom;
        final content = twoColumns
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _column(main)),
                  const Gap.horizontal(width: 20),
                  Expanded(flex: sideFlex, child: _column(side)),
                ],
              )
            : _column([
                ...main,
                if (sideLabels case final labels?
                    when labels.length == side.length && side.isNotEmpty)
                  SegmentedPanels(
                    panels: [
                      for (var i = 0; i < side.length; i++)
                        Panel(label: labels[i], child: side[i]),
                    ],
                  )
                else
                  ...side,
              ]);
        final padding = constraints.maxWidth >= twoColumnsFrom ? 24.0 : 16.0;
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(padding),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: content,
            ),
          ),
        );
      },
    );
    final refresh = onRefresh;
    return refresh == null
        ? body
        : RefreshIndicator(onRefresh: refresh, child: body);
  }
}
