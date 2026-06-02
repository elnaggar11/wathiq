import 'package:flutter/material.dart';

class AppFonts {
  const AppFonts._();
  static const AppFonts _instance = AppFonts._();
  factory AppFonts() => _instance;

  static const String tajawal = 'Tajawal';
}

class AppFontsWeight {
  const AppFontsWeight._();
  static const AppFontsWeight _instance = AppFontsWeight._();
  factory AppFontsWeight() => _instance;

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

class FontSize {
  const FontSize._();
  static const FontSize _instance = FontSize._();
  factory FontSize() => _instance;

  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
}
