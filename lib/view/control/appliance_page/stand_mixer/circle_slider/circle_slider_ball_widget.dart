import 'package:flutter/material.dart';

class CircleSliderBallWidget extends StatelessWidget {
  late final double radius;
  late final BoxDecoration decoration;

  final defaultDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(99)
  );

  CircleSliderBallWidget({
    required this.radius,
    BoxDecoration? decoration,
    Key? key
  }) : super(key: key) {
    this.decoration = decoration ?? defaultDecoration;
  }

  CircleSliderBallWidget.circular({
    Key? key,
    required this.radius
  }) : super(key: key) {
    decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(99)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: decoration
    );
  }
}
