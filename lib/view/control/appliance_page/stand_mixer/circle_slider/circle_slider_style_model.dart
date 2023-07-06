import 'package:flutter/material.dart';

class CircleSliderStyleModel {
  final List<Color>? outlineColor;
  final List<Color>? valueColor;
  final List<Color>? valueOutlineColor;
  CircleSliderGlow? glow;

  final bool isFilled;

  CircleSliderStyleModel.sweepGradient({
    required this.outlineColor,
    required this.valueColor,
    this.isFilled = false,
    this.valueOutlineColor,
    this.glow
  });
}

class CircleSliderGlow {
  final double min;
  final double max;
  final Duration duration;

  CircleSliderGlow({
    required this.min,
    required this.max,
    required this.duration
  });
}
