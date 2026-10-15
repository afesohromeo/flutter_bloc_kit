import 'package:flutter/material.dart';

/// Text on one line (e.g. an amount like "20,650,000 FCFA"), shrunk to fit
/// its space rather than wrapped onto two.
class OneLineText extends StatelessWidget {
  const OneLineText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text, maxLines: 1, softWrap: false, style: style),
    );
  }
}
