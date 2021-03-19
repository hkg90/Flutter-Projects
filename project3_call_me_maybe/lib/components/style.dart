import 'package:flutter/material.dart';

// Contains set styles for majority of app (font sizes and main font family)
class Styles {
  static double textSmall = 12.0;
  static double textMed = 15.0;
  static double textLarge = 20.0;
  static final String _fontName = 'Pacifico';
  
  static final appTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.redAccent,
    fontFamily: _fontName,
  );
}