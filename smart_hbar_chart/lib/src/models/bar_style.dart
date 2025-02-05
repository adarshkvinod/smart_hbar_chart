import 'package:flutter/material.dart';

class SmartBarStyle {
  final List<Color> barGradientColors;
  final Color backgroundColor;
  final Color rulerColor;
  final Color textColor;
  final double barHeight;
  final double barBorderRadius;
  final double imageSize;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;
  final EdgeInsets padding;
  final Duration animationDuration;

  const SmartBarStyle({
    this.barGradientColors = const [Colors.blue, Colors.lightBlue],
    this.backgroundColor = const Color(0xFFF4F4F4),
    this.rulerColor = const Color(0xFFE7E7E7),
    this.textColor = const Color(0xFF3D3D3D),
    this.barHeight = 32.0,
    this.barBorderRadius = 8.0,
    this.imageSize = 24.0,
    this.labelTextStyle,
    this.valueTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.animationDuration = const Duration(seconds: 2),
  });
}
