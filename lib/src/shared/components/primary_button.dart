import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.withBg = true,
      this.buttonColor,
      this.borderColor,
      this.shape,
      this.height,
      this.inkRaduis,
      this.width,
      this.w2});

  final Color? buttonColor;
  final Color? borderColor;

  final VoidCallback? onPressed;

  final ShapeBorder? shape;

  final Widget child;
  final double? height;
  final double? width;
  final double? w2;

  final double? inkRaduis;
  final bool? withBg;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: ResponsiveLayout.isMobile(context)
          ? width
          : w2, // Set the minimum width to zero
      height: 0, // Set the minimum height to zero
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      disabledColor: customColors.surface,
      disabledElevation: 0,
      disabledTextColor: customColors.error,
      padding: EdgeInsets.all(0),
      visualDensity: VisualDensity(vertical: -4, horizontal: -4),

      // minWidth: 1,

      elevation: 20,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
            gradient: withBg!
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [
                      0.4,
                      0.9,
                    ],
                    colors: [
                      customColors.primary.withValues(alpha: .9),
                      customColors.primary,
                    ],
                  )
                : null,
            color: onPressed != null
                ? buttonColor ?? customColors.primary
                : customColors.surface,
            borderRadius: BorderRadius.all(
              Radius.circular(inkRaduis ?? 20.0),
            )),
        child: Container(
            height: height,
            width: ResponsiveLayout.isMobile(context) ? width : w2 ?? width,
            alignment: Alignment.center,
            child: child),
      ),
    );
  }
}
