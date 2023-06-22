import 'package:flutter/material.dart';

import '../resources/values_manager.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.child,
    this.disableBorder = false,
    this.width,
    this.height,
    this.disablePadding = false,
    this.cColor,
    this.bColor, this.shape,
  });
  final Widget? child;
  final bool disableBorder, disablePadding;
  final double? width, height;
  final Color? cColor, bColor;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width ?? SpacingManager.mainWidth(context),
          height: height,
          padding: disablePadding
              ? null
              : const EdgeInsets.all(SpacingManager.sidesSpace / 3),
          decoration: BoxDecoration(
            shape: shape??BoxShape.rectangle,
              color: cColor,
              borderRadius: BorderRadius.circular(12),
              border: !disableBorder
                  ? Border.all(
                      width: 2.5,
                      color: bColor ?? Theme.of(context).dividerColor,
                    )
                  : null),
          child: Center(child: child ?? const SizedBox()),
        ),
      ],
    );
  }
}
