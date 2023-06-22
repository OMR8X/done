import 'package:flutter/material.dart';

class SpacingManager {
  static const double topSpace = 60.0;
  static const double sidesSpace = 40.0;
  static const double mainSpace = 10.0;
  //values
  static const double space4 = 4.0;
  static const double space6 = 6.0;
  static const double space8 = 8.0;
  static const double space10 = 10.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space18 = 18.0;
  static const double space20 = 20.0;
  static const double space22 = 22.0;

  static mainWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width - sidesSpace;
    return width;
  }

  static dividWidth(BuildContext context, int value) {
    double width = (mainWidth(context) / value) - (mainSpace / value);
    return width;
  }
}

class BorderRadiusManager {
  static const double mainRadius = 8;
  static const double radius8 = 8.0;
  static const double radius10 = 10.0;
  static const double radius12 = 12.0;
  static const double radius14 = 14.0;
  static const double radius16 = 16.0;
  static const double radius18 = 18.0;
  static const double radius20 = 20.0;
  static const double radius22 = 22.0;
}

class ShadowsManager {
  static const BoxShadow miniShadow = BoxShadow();
  static BoxShadow mediumShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    offset: const Offset(0, 4),
    blurRadius: 2,
    spreadRadius: 3,
  );
  static const BoxShadow largShadow = BoxShadow();
}
