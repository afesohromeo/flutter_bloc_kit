import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Lays [child] out as usual, but reports no intrinsic height, so inside an
/// [IntrinsicHeight] row it fills the height the other children set instead
/// of setting it. Used for a photo next to a card: a portrait photo would
/// otherwise make the row as tall as the photo.
class IgnoreIntrinsicHeight extends SingleChildRenderObjectWidget {
  const IgnoreIntrinsicHeight({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderIgnoreIntrinsicHeight();
}

class _RenderIgnoreIntrinsicHeight extends RenderProxyBox {
  @override
  double computeMinIntrinsicHeight(double width) => 0;

  @override
  double computeMaxIntrinsicHeight(double width) => 0;
}
