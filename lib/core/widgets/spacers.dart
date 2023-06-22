import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

enum SType {
  inf,
  main,
  halfMain,
  twiceMain,
}

class MainSpacer extends StatelessWidget {
  const MainSpacer({
    super.key,
    this.spacerType,
    this.axisDirection,
  });
  final SType? spacerType;
  final Axis? axisDirection;
  @override
  Widget build(BuildContext context) {
    double width = 0, height = 0, value = 0;
    switch (spacerType) {
      case SType.inf:
        value = double.infinity;
        break;
      case SType.main:
        value = SpacingManager.mainSpace;
        break;
      case null:
        value = SpacingManager.mainSpace;
        break;
      case SType.halfMain:
        value = SpacingManager.mainSpace / 2;
        break;
      case SType.twiceMain:
        value = SpacingManager.mainSpace * 2;
        break;
    }
    switch (axisDirection) {
      case Axis.horizontal:
        width = value;
        break;
      case Axis.vertical:
        height = value;
        break;
      case null:
        height = value;
        break;
    }
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
