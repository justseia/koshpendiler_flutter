import 'package:flutter/material.dart';

class ColorsApp {
  static Color transparent = const Color(0x00000000);
  static Color mainColor = const Color(0xFF9A6722);
  static Color white = const Color(0xFFFEFDFE);
  static Color black = const Color(0xFF0F1210);
  static Color black2c = const Color(0xFF2C302D);
  static Color navBar = const Color(0xFF0F1210);
  static Color grayText = const Color(0xFFA5AAA6);
  static Color grayInput = const Color(0xFF232725);
  static Color disableButton = const Color(0xFF4D4C4D);
  static Color whiteRozoviy = const Color(0xffEBE7EB);
  static Color cardColor = const Color(0xffC5B9A8);
  static Color yellowbd = const Color(0xffBD935B);
}

MaterialColor colorsApp(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
