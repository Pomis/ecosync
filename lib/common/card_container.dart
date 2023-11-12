import 'dart:math';

import 'package:flutter/material.dart';
import 'package:junction2023/common/colors.dart';

import 'tap_area.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? aspectRatio;
  final bool? hasShadow;
  final Widget? background;
  final List<Color>? gradientColors;
  final bool hasBorder;
  final bool hasArrow;
  final double borderRadius;
  final Color? color;

  const CardContainer({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.background,
    this.onTap,
    this.onLongTap,
    this.aspectRatio,
    this.gradientColors,
    this.hasShadow,
    this.hasArrow = false,
    this.hasBorder = false,
    this.color,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorStore.secondaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: margin ?? EdgeInsets.zero,
      width: MediaQuery.of(context).size.width,
      height: aspectRatio != null ? (MediaQuery.of(context).size.width * aspectRatio!) : null,
      child: Stack(
        children: [
          if (background != null)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: gradientColors != null ? _backgroundImage() : background,
              ),
            ),
          _content(context),
        ],
      ),
    );
  }

  Widget _content(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: TapArea(
        padding: padding,
        borderRadius: borderRadius,
        onTap: onTap,
        onLongTap: onLongTap,
        child: child,
      ),
    );
  }

  Widget _backgroundImage() {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (rectangle) => LinearGradient(
        begin: Alignment.topCenter,
        colors: gradientColors!,
        end: Alignment.bottomCenter,
      ).createShader(rectangle),
      child: background,
    );
  }
}
