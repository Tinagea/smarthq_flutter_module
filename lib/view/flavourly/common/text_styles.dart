
import 'package:smarthq_flutter_module/view/flavourly/common/color.dart';
import 'package:flutter/material.dart';

TextStyle textStyle_size_18_bold_color_white() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle_size_38_bold_color_white() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 38,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle_size_38_color_purple() {
  return textStyle_size_custom_color_purple(fontSize: 38);
}

TextStyle textStyle_size_custom_color_purple({double fontSize=10}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: Colors.purpleAccent,
    fontWeight: FontWeight.normal,
  );
}

TextStyle textStyle_size_custom_color_purple_semi_bold({double fontSize=10}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: Colors.purpleAccent,
    fontWeight: FontWeight.w400,
  );
}

TextStyle textStyle_size_custom_color_purple_bold({double fontSize=10}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: Colors.purpleAccent,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle_size_custom_color_white({double fontSize=10}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
}

TextStyle textStyle_size_custom_color_white_bold({double fontSize=10}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: Colors.white,
    fontWeight: FontWeight.w900,
  );
}

TextStyle textStyle_size_16_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      wordSpacing: 2.67,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

// Gray
TextStyle textStyle_size_10_color_spanish_gray() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    color: colorSpanishGray(),
  );
}