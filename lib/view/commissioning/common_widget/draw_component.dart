import 'package:flutter/material.dart';

class RectangleDraw extends CustomPainter {
  final double _width;
  final double _rectHeight;
  final Color _color;
  final double _heightOffset;
  RectangleDraw(this._width, this._rectHeight, this._color, this._heightOffset);

  @override
  void paint(Canvas canvas, Size size) {
    var myPaint = Paint();
    // canvas.drawLine(Offset(10.0, 10.0), Offset(100.0, 200.0), myPaint);
    myPaint.color = this._color;
    canvas.drawRect(Rect.fromCenter(center: Offset(0, this._rectHeight / 2 + this._heightOffset), width: this._width, height: this._rectHeight), myPaint);

    // canvas.drawRect(
    //   new Rect.fromLTRB(
    //       0.0, 0.0, this._width, _rectHeight
    //   ),
    //   // new Paint()..color = new Color(0xFF0099FF),
    //   new Paint()..color = this._color,
    // );
  }

  @override
  bool shouldRepaint(RectangleDraw oldDelegate) {
    return false;
  }
}