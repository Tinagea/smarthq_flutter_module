
import 'package:flutter/material.dart';

class Theme {
  late String fontFamily;
  late Color background;
  late AppBarTheme barTheme;
}

class DefaultTheme extends Theme {
  String fontFamily = 'Poppins';
  Color background = Colors.black;
  AppBarTheme barTheme = AppBarTheme(color: Colors.black);
}