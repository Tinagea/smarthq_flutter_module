import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_painter.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_ball_model.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_style_model.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_ball_widget.dart' as slider_ball_widget;

class CircleSliderWidget extends StatefulWidget {
  late final double value;
  final slider_ball_widget.CircleSliderBallWidget ball;
  final Widget? centerChild;

  final double diameter;
  final double thickness;

  final bool isRunning;

  final CircleSliderStyleModel style;

  late final double startAngle;
  late final double endAngle;

  final Function(double)? onChanged;

  Offset get _center {
    return Offset(diameter / 2, diameter / 2);
  }

  double get _radius {
    return diameter / 2;
  }

  double get _totalAvailableArc {
    return (2 * pi) - (endAngle - startAngle);
  }

  CircleSliderWidget({
    required double value,
    required this.style,
    required this.diameter,
    required this.thickness,
    required this.ball,
    required this.isRunning,
    this.centerChild,
    this.onChanged,
    double? startAngle,
    double? endAngle,
    Key? key
  }) : super(key: key) {
    this.value = (value < 0 || value > 1) ? (value < 0 ? 0 : 1) : value;
    this.startAngle = radians(startAngle ?? 0);
    this.endAngle = radians(endAngle ?? 360);
  }

  @override
  _CircleSliderState createState() => _CircleSliderState();
}

class _CircleSliderState extends State<CircleSliderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowAnimationController;
  late Animation _glowAnimation;

  @override
  initState() {
    var circleGlow = widget.style.glow;

    if (circleGlow != null) {
      _glowAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1200),
      );
      _glowAnimationController.repeat(reverse: true);
      _glowAnimation = Tween(begin: circleGlow.min, end: circleGlow.max)
          .animate(_glowAnimationController)
        ..addListener(() {
          setState(() {});
        });
    }

    super.initState();
  }

  @override
  dispose() {
    _glowAnimationController.dispose();
    super.dispose();
  }

  late double value = widget.value;

  late CircleSliderBallModel sliderBall = CircleSliderBallModel(
    startingAngle: _angleOfValue,
    pivotPoint: widget._center,
    pivotRadius: widget._radius - widget.thickness / 2
  );

  // allows for clean 0, and 1 for user
  double get _value {
    if (value < .004) return 0.0;

    if (value > .994) return 1.0;

    return value;
  }

  @override
  Widget build(BuildContext context) {
    value = widget.value;
    sliderBall.angle = _angleOfValue;

    return SizedBox(
      width: widget.diameter,
      height: widget.diameter,
      child: Listener(
        onPointerMove: (pointerMove) => _updateSliderWithPointer(pointerMove),
        onPointerDown: (pointerDown) => _updateSliderWithPointer(pointerDown),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(widget.diameter, widget.diameter),
              painter: CircleSliderPainter(
                style: widget.style,
                context: this.context,
                blurThickness: _glowAnimation.value,
                circleSlider: widget,
                sliderValueSize: _arcProportionalToValue(_value),
              ),
            ),
            Positioned(
              child: widget.ball,
              left: sliderBall.position.dx - widget.ball.radius,
              top: sliderBall.position.dy - widget.ball.radius,
            ),
            Center(
              child: widget.centerChild,
            ),
          ],
        ),
      ),
    );
  }

  double _arcProportionalToValue(double value) {
    var totalPie = (2 * pi) - (widget.endAngle - widget.startAngle);

    return totalPie * value;
  }

  double get _angleOfValue {
    return flipAngle(widget.startAngle) + (widget._totalAvailableArc * value);
  }

  double _getValueFromCoordinates(Offset pointerPosition) {
    var angleToPointer = angleBetweenPoints(
        source: pointerPosition, destination: widget._center);

    bool belowStartAngle = angleToPointer < flipAngle(widget.startAngle);
    bool aboveEndAngle = angleToPointer > (flipAngle(widget.endAngle));
    bool outsideOfRange = belowStartAngle && aboveEndAngle;
    Offset dPosition = pointerPosition - sliderBall.position;
    bool outsideSliderBall =
        sqrt((dPosition.dy * dPosition.dy) + (dPosition.dx * dPosition.dx)) >
            (widget.ball.radius + 20.0);

    if (outsideOfRange || outsideSliderBall) {
      throw Exception('position outside of range');
    }

    if (angleToPointer < flipAngle(widget.startAngle)) {
      angleToPointer += 2 * pi;
    }

    return _getValueFromAngle(angleToPointer);
  }

  double angleBetweenPoints({
    required Offset destination,
    required Offset source,
  }) {
    var angleBetweenPoints = atan2(
      source.dy - destination.dy,
      source.dx - destination.dx
    );

    return angleBetweenPoints;
  }

  double _getValueFromAngle(double angle) {
    double angleFromStart = angle - (flipAngle(widget.startAngle));
    double calculatedValue = angleFromStart / widget._totalAvailableArc;

    if (calculatedValue > value && widget.isRunning) {
      throw Exception("cannot increase when mixer is running");
    }
    else {
      return calculatedValue;
    }
  }

  void _updateSliderWithPointer(PointerEvent pointerMove) {
    var pointerPosition = pointerMove.localPosition;

    try {
      setState(() {
        value = _getValueFromCoordinates(pointerPosition);
        if (value < 0.02) {
          value = value + 0.02;
        }
        else if (value > 0.98) {
          value = value - 0.02;
        }
      });
    }
    catch (ex) {
      // invalid touch
    }

    widget.onChanged?.call(value);
  }

  double flipAngle(double angle) {
    return (2 * pi) - angle;
  }
}
