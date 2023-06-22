import 'package:flutter/cupertino.dart';

class FontStylesManager {
  static const String fontFamily = 'ReadexPro';
  static TextStyle getFontStyle({
    double? fontSize,
    double? height,
    double? lettersSpacing,
    double? wordsSpacing,
    Color fontColor = const Color(0xffC0C0C0),
    FontWeight fontWeight = FontWeightManager.medium,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: fontColor,
      wordSpacing: wordsSpacing,
      letterSpacing: lettersSpacing,
      height: height,
    );
  }
}

class FontWeightManager {
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300; //
  static const FontWeight regular = FontWeight.w400; //
  static const FontWeight medium = FontWeight.w500; //
  static const FontWeight semiBoldght = FontWeight.w600; //
  static const FontWeight bold = FontWeight.w700; //
}

class FontSize {
  static const double s12 = 12.0;
  static const double s14 = 14.0;
  static const double s16 = 16.0;
  static const double s18 = 18.0;
  static const double s20 = 20.0;
  static const double s22 = 22.0;
  static const double s24 = 24.0;
  static const double s28 = 28.0;
  static const double s32 = 32.0;
}
