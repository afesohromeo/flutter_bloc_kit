import 'package:flutter/material.dart';

class ResponsiveDialogWrapper extends StatelessWidget {
  final Widget child;
  final double maxDialogWidth;
  final EdgeInsets? insetPadding;
  final ShapeBorder? shape;

  const ResponsiveDialogWrapper({
    super.key,
    required this.child,
    this.maxDialogWidth = 500,
    this.insetPadding,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Dialog(
      insetPadding:
          insetPadding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      // backgroundColor: AppTheme.light.dialogTheme.backgroundColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isMobile ? double.infinity : maxDialogWidth,
        ),
        child: child,
      ),
    );
  }
}
