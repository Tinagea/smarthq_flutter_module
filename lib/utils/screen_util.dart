// file: screen_util.dart
// date: Jun/14/2021
// brief: A class to change width and height depending on screen size.
// Copyright GE Appliances, a Haier company (Confidential). All rights reserved.


import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

class ScreenUtils {

  static double get _ppi => (Platform.isAndroid || Platform.isIOS)? 150 : 96;
  static bool isLandscape(BuildContext c) => MediaQuery.of(c).orientation == Orientation.landscape;
  //PIXELS
  static Size screenSize(BuildContext c) => MediaQuery.of(c).size;
  static EdgeInsets paddingSize(BuildContext c) => MediaQuery.of(c).padding;
  static double screenWidth(BuildContext c) => screenSize(c).width;
  static double screenHeight(BuildContext c) => screenSize(c).height;
  static double screenSafetyAreaTopHeight(BuildContext c) => paddingSize(c).top;
  static double screenSafetyAreaBottomHeight(BuildContext c) => paddingSize(c).bottom;
  static double appBarHeight = AppBar().preferredSize.height;

  static double screenDiagonal(BuildContext c) {
    Size s = screenSize(c);
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(BuildContext c) {
    Size pxSize = screenSize(c);
    return Size(pxSize.width / _ppi, pxSize.height/ _ppi);
  }
  static double widthInches(BuildContext c) => inches(c).width;
  static double heightInches(BuildContext c) => inches(c).height;
}