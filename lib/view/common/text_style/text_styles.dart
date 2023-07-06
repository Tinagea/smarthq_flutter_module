// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:smarthq_flutter_module/view/common/color/colors.dart';

// Gray
TextStyle textStyle_size_10_color_spanish_gray() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    color: colorSpanishGray(),
  );
}

TextStyle textStyle_size_12_color_old_silver() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: colorOldSilver(),
  );
}

TextStyle textStyle_size_12_color_grey() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: colorGrey(),
  );
}

TextStyle textStyle_size_13_color_old_silver() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 13,
    color: colorSpanishGray(),
  );
}

TextStyle textStyle_size_14_light_color_grey() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w100,
    color: Colors.grey
  );
}

TextStyle textStyle_size_14_color_grey() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.grey
  );
}

TextStyle textStyle_size_14_color_grey_spaced() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: Colors.grey,
    letterSpacing: 0.4,
  );
}


TextStyle textStyle_size_15_color_old_silver() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    color: colorOldSilver(),
  );
}

TextStyle textStyle_size_15_color_grey() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    color: colorGrey(),
  );
}

TextStyle textStyle_underline_size_15_color_grey() {
  return TextStyle(
    fontSize: 15,
    fontFamily: 'Poppins',
    color: Colors.transparent,
    shadows: [
      Shadow(
          color: Colors.grey,
          offset: Offset(0, -5))
    ],
    decorationColor: Colors.grey,
    decorationThickness: 2,
    decoration: TextDecoration.underline,
  );
}

TextStyle textStyle_size_16_semi_bold_color_light_silver() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      letterSpacing: 0.3,
      color: colorLightSilver(),
      fontWeight: FontWeight.w500);
}

TextStyle textStyle_size_18_color_grey() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.grey,
  );
}

TextStyle textStyle_size_18_bold_color_grey() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: Colors.grey,
      fontWeight: FontWeight.bold
  );
}

TextStyle textStyle_size_16_semi_bold_color_dark_grey() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: colorDarkCharcoal(),
  );
}

TextStyle textStyle_size_16_light_color_grey() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w100,
    color: Colors.grey
  );
}

TextStyle textStyle_size_24_color_old_silver() {
  return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      color: colorOldSilver());
}

// White
TextStyle textStyle_size_12_white_50_opacity() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: Colors.white.withOpacity(0.5),
  );
}

TextStyle textStyle_size_13_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 13,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size_14_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white);
}

TextStyle textStyle_size_14_bold_color_white_33_opacity() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white.withOpacity(0.33),
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size_14_color_white_spaced() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white,
      letterSpacing: 0.4
      );
}

TextStyle textStyle_size_14_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size_14_color_white_50_opacity() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white.withOpacity(0.5));
}

TextStyle textStyle_size_14_bold_color_white_spaced() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size_14_light_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w100);
}

TextStyle textStyle_size_14_color_white_underlined() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w100,
      decoration: TextDecoration.underline);
}

TextStyle textStyle_size_15_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 15,
      wordSpacing: 3.0,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size_16_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      wordSpacing: 2.0,
      color: Colors.white);
}

TextStyle textStyle_size_16_bold_color_white_wide() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    wordSpacing: 2.67,
    letterSpacing: 4.5,
    color: Colors.white,
    fontWeight: FontWeight.w700
  );
}

TextStyle textStyle_size_16_bold_color_white_wide_faded() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    wordSpacing: 2.67,
    letterSpacing: 4.5,
    fontWeight: FontWeight.w700,
    color: Colors.white.withOpacity(0.5)
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

TextStyle textStyle_size_16_color_white_75_opacity() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      wordSpacing: 2.67,
      color: Colors.white.withOpacity(0.75));
}

TextStyle textStyle_size_16_light_color_white_33_opacity() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: Colors.white.withOpacity(0.33),
    fontWeight: FontWeight.w100,
  );
}
TextStyle textStyle_size_17_color_white() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 17,
    color: Colors.white,
  );
}

TextStyle textStyle_size_18_color_white() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white,
  );
}

TextStyle textStyle_size_18_color_white_50_opacity() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white.withOpacity(0.5),
  );
}

TextStyle textStyle_size_18_bold_color_white() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle_size_18_light_color_white_33_opacity() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white.withOpacity(0.33),
    fontWeight: FontWeight.w100,
  );
}

TextStyle textStyle_size_18_light_color_white_66_opacity() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white.withOpacity(0.66),
    fontWeight: FontWeight.w300
  );
}

TextStyle textStyle_size_18_bold_color_white_spaced() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.8,
    color: Colors.white
  );
}

TextStyle textStyle_size_20_color_white() {
  return TextStyle(
   fontFamily: 'Poppins',
   fontSize: 20, 
   color: Colors.white);
}

TextStyle textStyle_size_20_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white);
}

TextStyle textStyle_size_20_bold_color_white_66_opacity() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    color: Colors.white.withOpacity(0.66),
    fontWeight: FontWeight.bold
  );
}

TextStyle textStyle_size_24_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size_24_color_white() {
  return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      color: Colors.white);
}

TextStyle textStyle_bold_size_24_color_white() {
  return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      color: Colors.white,
      fontWeight: FontWeight.bold);
}

TextStyle textStyle_size24_color_white() {
  return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      color: Colors.white);
}

TextStyle textStyle_size_18_normal400_color_white() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w400
  );
}


TextStyle textStyle_bold_size_32_color_white() {
  return TextStyle(
      fontSize: 32,
      fontFamily: 'Poppins',
      color: Colors.white,
      fontWeight: FontWeight.bold);
}


TextStyle textStyle_size_36_color_white() {
  return TextStyle(
      fontFamily: 'Poppins', fontSize: 36, color: Colors.white);
}

TextStyle textStyle_bold_size_36_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 36,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}


TextStyle textStyle_size_64_bold_color_white() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 64,
      fontWeight: FontWeight.w400,
      letterSpacing: .3,
      color: Colors.white);
}

// Black
TextStyle textStyle_size_14_color_dark_charcoal() {
  return TextStyle(
    fontSize: 14,
    color: colorDarkCharcoal(),
    fontFamily: "Poppins",
  );
}

TextStyle textStyle_size_14_color_raisin_black() {
  return TextStyle(
    fontSize: 14,
    color: colorRaisinBlack(),
    fontFamily: "Poppins",
  );
}

TextStyle textStyle_size_16_semi_bold_color_black() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
}

TextStyle textStyle_size_14_color_black() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.black
  );
}

TextStyle textStyle_size_18_color_black() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.black,
  );
}

TextStyle textStyle_size_18_bold_color_black() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.bold
  );
}


TextStyle textStyle_size_20_bold_color_black() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

// Purple
TextStyle textStyle_size_18_bold_deep_purple() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      color: colorDeepPurple(),
      fontWeight: FontWeight.bold
  );
}

TextStyle textStyle_size_20_bold_color_deep_purple() {
  return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: colorDeepPurple(),
      fontFamily: 'Poppins'
  );
}

TextStyle textStyle_size_14_bold_color_deep_purple() {
  return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      color: colorDeepPurple(),
      fontWeight: FontWeight.bold);
}
TextStyle textStyle_size_15_color_purple() {
  return TextStyle(fontFamily: 'Poppins',
      fontSize: 14,
      color: Colors.purple);
}
TextStyle textStyle_size_15_color_deep_purple() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    color: colorDeepPurple(),
  );
}


TextStyle textStyle_size_16_bold_color_deep_purple() {
  return TextStyle(
    color: colorDeepPurple(),
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
}

// Yellow
TextStyle textStyle_size_18_color_yellow() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: colorAmericanYellow(),
  );
}

TextStyle textStyle_size_18_color_yellow_underlined() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: colorAmericanYellow(),
    decoration: TextDecoration.underline,
  );
}

TextStyle textStyle_size_18_bold_color_yellow() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: colorSelectiveYellow(),
    fontWeight: FontWeight.bold,
  );
}

TextStyle textStyle_size_24_color_yellow() {
  return TextStyle(
      fontSize: 24,
      fontFamily: 'Poppins',
      color: colorSelectiveYellow());
}

TextStyle textStyle_size_30_color_yellow() {
  return TextStyle(
      fontFamily: 'Poppins', 
      fontSize: 30, 
      color: colorAmericanYellow());
}

// Color Changable
TextStyle textStyle_size_13_color_spaced() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 13,
    letterSpacing: 0.4,
  );
}

TextStyle textStyle_size_18_bold() {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}