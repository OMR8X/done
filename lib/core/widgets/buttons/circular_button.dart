//
import 'package:done/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    this.hide = false,
    this.svgPath = UIAssetsManger.playIcon,
    this.onPress,
    this.isSelected = false,
  });
  final bool hide;
  final String svgPath;
  final VoidCallback? onPress;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    Color color = hide ? Colors.transparent : Theme.of(context).primaryColor;
    double size = 30;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (onPress == null) return;
        onPress!();
      },
      child: ClipOval(
        child: CircleAvatar(
          radius: size,
          backgroundColor: color,
          child: SvgPicture.asset(
            svgPath,
            colorFilter: isSelected
                ? ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  )
                : null,
            width: size / 1.5,
          ),
        ),
      ),
    );
  }
}
