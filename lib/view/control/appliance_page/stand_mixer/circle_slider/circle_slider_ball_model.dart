import 'dart:math';
import 'dart:ui';

class CircleSliderBallModel {
  late double angle;
  final Offset pivotPoint;
  final double pivotRadius;

  CircleSliderBallModel({
    required double startingAngle,
    required this.pivotPoint,
    required this.pivotRadius
  }) {
    angle = startingAngle;
  }

  Offset get position {
    var dX = cos(angle) * pivotRadius;
    var dY = sin(angle) * pivotRadius;

    return Offset(pivotPoint.dx + dX, pivotPoint.dy + dY);
  }
}
