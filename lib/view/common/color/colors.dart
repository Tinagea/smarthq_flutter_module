
import 'package:flutter/material.dart';

// Color names from https://www.schemecolor.com/sample?getcolor={color_code} eg)https://www.schemecolor.com/sample?getcolor=d8d8d8
Color colorLightSilver() {
  return Color(0xffd8d8d8); //Colors.fromARGB(255, 216, 216, 216)
}

Color colorSpanishGray() {
  return Color(0xff989898); //Colors.fromARGB(255, 152, 152, 152)
}

Color colorOldSilver() {
  return Color(0xff828282); //Color.fromARGB(255, 130, 130, 130)
}

Color colorDarkLiver() {
  return Color(0xff4f4f4f); //Color.fromARGB(255, 79, 79, 79)
}

Color colorDarkCharcoal() {
  return Color(0xff303134); //Color.fromARGB(255, 48, 49, 52)
}

Color colorDeepDarkCharcoal() {
  return Color(0xff2c2c2c); //Color.fromARGB(255, 44, 44, 44)
}

Color colorRaisinBlack() {
  return Color(0xff202022); //Color.fromARGB(255, 32, 32, 34)
}

Color colorEerieBlack() {
  return Color(0xff1e1e1e); //Color.fromARGB(255, 30, 30, 30)
}

Color colorSelectiveYellow() {
  return Color(0xffffbb00); //Color.fromARGB(255, 255, 187, 0)
}

Color colorDeepPurple() {
  return Color(0xffa11f7f); //Color.fromARGB(255, 161, 31, 127)
}

Color colorAmericanYellow() {
  return Color(0xfff2a900); //Color.fromARGB(255, 242, 169, 0)
}

Color colorBrilliantAzure() {
  return Color(0xff42a5ff); //Color.fromARGB(255, 66, 165, 255)
}

Color colorOuterSpace() {
  return Color(0xff464646); //Color.fromARGB(255, 70, 70, 70)
}

Color colorGrey() {
  return Color(0xff828282); //Color.fromARGB(255, 130, 130, 130)
}

Color colorPigmentRed() {
  return Color(0xffed2024); //Color.fromARGB(255, 237, 32, 36)
}

Gradient gradientDarkGreyCharcoalGrey() {
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [colorDeepDarkCharcoal(), colorDarkCharcoal()]
  );
}

Gradient gradientRaisinBlackDarkCharcoal() {
  return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [colorRaisinBlack(), colorDarkCharcoal()]
  );
}