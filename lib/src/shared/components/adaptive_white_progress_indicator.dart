import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

import 'package:flutter/material.dart';

class AdaptiveWhiteProgressIndicator extends StatelessWidget {
  const AdaptiveWhiteProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: AppColors.white1),
      ),
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
