import 'package:flutter/material.dart';

class BaseComponent {
  static Widget heightSpace(double _height) {
    return SizedBox(width: double.infinity, height: _height);
  }
  static Widget widthSpace(double _width) {
    return SizedBox(width: _width);
  }
}