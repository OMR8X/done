import 'package:flutter/material.dart';

import '../resources/font_manager.dart';

class CustomAppTheme {
  static bool ligthTheme = false;
  static getTheme() {
    return ligthTheme ? getLigthTheme() : getDarkTheme();
  }
}

ThemeData getDarkTheme(
    {Color? mainColor, Color? textColor, Color? backgroundColor}) {
  mainColor = mainColor ?? const Color(0xffFEC60C);
  backgroundColor = backgroundColor ?? const Color(0xff262626);
  textColor = textColor ?? Colors.white;

  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: mainColor,
    dividerColor: const Color(0xff383838),
    scaffoldBackgroundColor: const Color(0xff262626),
    fontFamily: "ReadexPro",
    appBarTheme: const AppBarTheme(
      toolbarHeight: 60,
      elevation: 0,
      color: Color(0xff262626),
      titleTextStyle: TextStyle(fontSize: 18, fontFamily: "ReadexPro"),
    ),
    textTheme: TextTheme(
      headlineLarge: FontStylesManager.getFontStyle(
        fontSize: 32,
        fontWeight: FontWeightManager.bold,
        fontColor: textColor,
      ),

      headlineMedium: FontStylesManager.getFontStyle(
        fontSize: 28,
        fontWeight: FontWeightManager.medium,
        fontColor: textColor,
      ),

      headlineSmall: FontStylesManager.getFontStyle(
        fontSize: 24,
        fontWeight: FontWeightManager.medium,
        fontColor: textColor,
      ),
      //
      //
      titleLarge: FontStylesManager.getFontStyle(
        fontSize: 20,
        fontWeight: FontWeightManager.medium,
        fontColor: textColor,
      ),

      titleMedium: FontStylesManager.getFontStyle(
        fontSize: 16,
        fontWeight: FontWeightManager.medium,
        fontColor: textColor,
      ),
      titleSmall: FontStylesManager.getFontStyle(
        fontSize: 14,
        fontWeight: FontWeightManager.medium,
        fontColor: textColor, //50
      ),

      //
      //
      labelLarge: FontStylesManager.getFontStyle(
          height: 1.5,
          fontSize: 14,
          fontWeight: FontWeightManager.regular,
          fontColor: textColor.withAlpha(200)),
      labelMedium: FontStylesManager.getFontStyle(
          height: 1.5,
          fontSize: 12,
          fontWeight: FontWeightManager.regular,
          fontColor: textColor.withAlpha(200)),
      labelSmall: FontStylesManager.getFontStyle(
        fontSize: 10,
        fontWeight: FontWeightManager.light,
        fontColor: textColor.withAlpha(200),
        height: 1.5,
        lettersSpacing: 0,
      ),
    ),
  );
}

ThemeData getLigthTheme({Color? mainColor, Color? backgroundColor}) {
  mainColor = mainColor ?? const Color(0xffFEC60C);
  backgroundColor = backgroundColor ?? const Color(0xff262626);
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xff262626),
    fontFamily: "ReadexPro",
    primaryColor: mainColor,
    dividerColor: const Color(0xff383838),
    appBarTheme: const AppBarTheme(
      toolbarHeight: 60,
      elevation: 0,
      color: Color(0xff262626),
      titleTextStyle: TextStyle(fontSize: 18, fontFamily: "ReadexPro"),
    ),
  );
}
