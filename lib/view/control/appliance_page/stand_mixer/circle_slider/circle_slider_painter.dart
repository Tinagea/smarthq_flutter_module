import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/utils/paint_util.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_style_model.dart';
import 'package:smarthq_flutter_module/view/control/appliance_page/stand_mixer/circle_slider/circle_slider_widget.dart';

class CircleSliderPainter extends CustomPainter {
  final CircleSliderWidget circleSlider;
  final double sliderValueSize;
  final BuildContext context;

  late final double _blurThickness;

  final CircleSliderStyleModel style;

  CircleSliderPainter({
    required this.context,
    required this.style,
    required this.sliderValueSize,
    required this.circleSlider,
    double? blurThickness
  }) {
    _blurThickness = blurThickness ?? 0;
  }

  Offset get _center {
    return Offset(circleSlider.diameter / 2, circleSlider.diameter / 2);
  }

  double get _radius {
    return circleSlider.diameter / 2;
  }

  Paint? colorsToPaint(List<Color>? colors) {
    if (colors == null) return null;
    if (colors.isEmpty) return null;

    if (colors.length == 1) {
      return Paint()
        ..color = colors[0]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
    }
    else {
      return Paint()
        ..shader = LinearGradient(
          begin: Alignment(0, 1),
          end: Alignment(0, -1),
          colors: colors
        ).createShader(
          Rect.fromCircle(
            center: _center,
            radius: _radius,
          ),
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = circleSlider.startAngle;
    double endAngle = circleSlider.endAngle;

    drawSliderFrame(
      canvas,
      startAngle,
      endAngle,
      _center,
      _radius,
      colorsToPaint(style.outlineColor),
      circleSlider.thickness
    );

    _drawSliderDynamicComponents(
      thickness: circleSlider.thickness,
      canvas: canvas,
      center: _center,
      radius: _radius,
      startAngle: startAngle,
      valuePaint: colorsToPaint(style.valueColor),
      valueOutlinePaint: colorsToPaint(style.valueOutlineColor)
    );
  }

  void drawSliderFrame(
    Canvas canvas,
    double start,
    double end,
    Offset center,
    double radius,
    Paint? tempPaint,
    double thickness
  ) {
    if (tempPaint == null) return;

    double sweep = 0;

    if (start > end) {
      sweep = -(end - start);
    }
    else {
      sweep = flipAngle(end - start);
    }

    // outside
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      (flipAngle(start)),
      (sweep),
      false,
      tempPaint
    );

    // inside
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - thickness),
      (flipAngle(start)),
      (sweep),
      false,
      tempPaint
    );

    //inside outline
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: (radius - thickness) + 7),
      (flipAngle(start)),
      (sweep),
      false,
            Paint()
        ..color = Colors.white54
        ..style = PaintingStyle.stroke
        ..strokeWidth = 16
    );

    var frontCap = getSliderCapPositions(
      center: center,
      radius: radius,
      angle: start,
      capLength: radius - thickness
    );

    var backCap = getSliderCapPositions(
      center: center,
      radius: radius,
      angle: end,
      capLength: radius - thickness
    );

    var capPaint = colorsToPaint(style.outlineColor);

    if (capPaint != null) {
      canvas.drawLine(frontCap.start, frontCap.end, capPaint);
      canvas.drawLine(backCap.start, backCap.end, capPaint);
    }
  }

  void _drawSliderDynamicComponents({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double startAngle,
    required double thickness,
    Paint? valuePaint,
    Paint? valueOutlinePaint
  }) {
    if (valuePaint == null) return;

    Paint outlinePaint = valueOutlinePaint ?? valuePaint;
    Paint fillPaint = valuePaint.copyWith(strokeWidth: thickness);

    // val fill
    if (style.isFilled) {
      // glow
      Paint fillGlowPaint = fillPaint.copyWith(
          maskFilter: MaskFilter.blur(BlurStyle.normal, _blurThickness));

      if (style.glow != null) {
        canvas.drawArc(
          Rect.fromCircle(
            center: center,
            radius: radius - (circleSlider.thickness / 2),
          ),
          (flipAngle(startAngle)),
          (sliderValueSize),
          false,
          fillGlowPaint
        );
      }

      canvas.drawArc(
        Rect.fromCircle(
            center: center, radius: radius - circleSlider.thickness / 2),
        (flipAngle(startAngle)),
        (sliderValueSize),
        false,
        fillPaint
      );
    }

    // val outside outline
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      (flipAngle(startAngle)),
      (sliderValueSize),
      false,
      outlinePaint
    );

    // val inside outline
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - circleSlider.thickness),
      (flipAngle(startAngle)),
      (sliderValueSize),
      false,
      outlinePaint
    );

    if (sliderValueSize > 0) {
      var cap = getSliderCapPositions(
        angle: circleSlider.startAngle,
        capLength: radius - circleSlider.thickness,
        center: center,
        radius: radius
      );

      canvas.drawLine(cap.start, cap.end, valuePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double flipAngle(double angle) {
    return (2 * pi) - angle;
  }
}

class Cap {
  final Offset start;
  final Offset end;

  Cap({required this.start, required this.end});
}

Cap getSliderCapPositions({
  required double angle,
  required double capLength,
  required Offset center,
  required double radius
}) {
  var angleInRadians = (angle);

  var start = Offset(
    center.dx + (cos(angleInRadians) * radius),
    center.dy - (sin(angleInRadians) * radius)
  );

  var end = Offset(
    center.dx + (cos(angleInRadians) * (capLength)),
    center.dy - (sin(angleInRadians) * (capLength))
  );

  return Cap(end: end, start: start);
}
