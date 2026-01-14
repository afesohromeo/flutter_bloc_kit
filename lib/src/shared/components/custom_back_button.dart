import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return IconButton(
          visualDensity: VisualDensity(vertical: -4, horizontal: -4),
          icon:
               Icon(Icons.arrow_back_ios, color: customColors.background),
          onPressed: () => context.pop(),
        );
      },
    );
  }
}
