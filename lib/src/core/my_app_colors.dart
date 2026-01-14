import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

class MyAppColors extends AppColors {
  final Color success;
  final Color warning;
  final Color black1;

  const MyAppColors({
    required super.primary,
    required super.secondary,
    required super.background,
    required super.surface,
    required super.error,
    required this.success,
    required this.warning,
    required this.black1,
  });
}
