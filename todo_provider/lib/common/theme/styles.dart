import 'package:flutter/material.dart';

class AppColors {
  static const Color mainAccentColor = Color(0xFF3D5AFE);
  static const Color blackColor = Colors.black87;

  static const MaterialColor mainBackgroundColor = MaterialColor(
    0xFFFAFAFA,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFEFEFE),
      200: Color(0xFFFDFDFD),
      300: Color(0xFFFCFCFC),
      400: Color(0xFFFBFBFB),
      500: Color(0xFFFAFAFA),
      600: Color(0xFFF5F5F5),
      700: Color(0xFFEEEEEE),
      800: Color(0xFFE0E0E0),
      900: Color(0xFFBDBDBD),
    },
  );
}

class Base {
  static const double tinyPadding = 2.0;
  static const double smallPadding = 4.0;
  static const double regularPadding = 8.0;
  static const double standardPadding = 16.0;
  static const double mediumPadding = 32.0;
  static const double bigPadding = 46.0;
  static const double superBigPadding = 52.0;
  static const double mainHorizontalPadding = 20.0;
  static const double buttonHorizontalPadding = 60.0;
  static const double topBarPadding = 26.0;
}
