import 'package:flutter/material.dart';

class Margin {
  static const double s = 4;

  static const double m = 8;

  static const double l = 12;

  static const double xl = 16;

  static const double xxl = 24;

  static const double xxll = 32;

  static const double xxxl = 64;
}

class TextStyles {
  static const TextStyle h1 =
      TextStyle(fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5);

  static const TextStyle h2 =
      TextStyle(fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5);

  static const TextStyle h3 =
      TextStyle(fontSize: 48, fontWeight: FontWeight.w400, letterSpacing: 0);

  static const TextStyle h4 =
      TextStyle(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25);

  static const TextStyle h5 =
      TextStyle(fontSize: 24, fontWeight: FontWeight.w400, letterSpacing: 0);

  static const TextStyle h6 =
      TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 0.15);

  static const TextStyle subtitle1 =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15);

  static const TextStyle subtitle2 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.1);

  static TextStyle body1(Color color) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: color);
  }

  static const TextStyle body2 =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25);

  // static const TextStyle button =
  //     TextStyle(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1.25);
  static TextStyle button(Color color) => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.25,
      color: color);

  static const TextStyle caption =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4);

  static const TextStyle overline =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5);
}
