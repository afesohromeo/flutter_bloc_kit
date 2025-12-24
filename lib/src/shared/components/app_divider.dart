import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Divider(
      height: 6,
      thickness: 1,
      color: AppColors.grey2,
    );
  }
}
