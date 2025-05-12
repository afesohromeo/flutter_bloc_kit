import 'package:flutter/material.dart';
import 'package:flutter_bloc_kit/flutter_bloc_kit.dart';

abstract class Gap extends StatelessWidget {
  const Gap({super.key});

  const factory Gap.horizontal({Key? key, required double width, double? w2}) =
      _HGap;

  const factory Gap.vertical({Key? key, required double height, double? h2}) =
      VGap;

  const factory Gap.horizontalSliver({
    Key? key,
    required double width,
    double? w2,
  }) = _HGapSliver;

  const factory Gap.verticalSliver({
    Key? key,
    required double height,
    double? h2,
  }) = _VGapSliver;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class VGap extends Gap {
  const VGap({super.key, required this.height, this.h2});

  final double height;
  final double? h2;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: ResponsiveLayout.isMobile(context)
          ? height
          : h2 ?? (height + (height * .8)));
}

class _VGapSliver extends StatelessWidget implements VGap {
  const _VGapSliver({
    super.key,
    required this.height,
    this.h2,
  });

  @override
  final double height;
  @override
  final double? h2;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
      child: SizedBox(
          height: ResponsiveLayout.isMobile(context)
              ? height
              : h2 ?? (height + (height * .8))));
}

class _HGap extends Gap {
  const _HGap({super.key, required this.width, this.w2});

  final double width;
  final double? w2;

  @override
  Widget build(BuildContext context) => SizedBox(
      width: ResponsiveLayout.isMobile(context)
          ? width
          : w2 ?? (width + (width * .8)));
}

class _HGapSliver extends StatelessWidget implements _HGap {
  const _HGapSliver({super.key, required this.width, this.w2});

  @override
  final double width;
  @override
  final double? w2;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
      child: SizedBox(
          width: ResponsiveLayout.isMobile(context)
              ? width
              : w2 ?? (width + (width * .8))));
}
