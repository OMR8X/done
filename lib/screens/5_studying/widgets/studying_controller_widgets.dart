import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/values_manager.dart';
import '../../../core/widgets/custom_container.dart';




class StudyingControllersWidget extends StatelessWidget {
  const StudyingControllersWidget({
    super.key,
    required this.pasued,
    required this.isStudying,
    this.pausePlayButton,
    this.stopeButton,
    this.restCompleteButton,
  });
  final bool pasued;
  final bool isStudying;
  final VoidCallback? pausePlayButton;
  final VoidCallback? stopeButton;
  final VoidCallback? restCompleteButton;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      disablePadding: true,
      disableBorder: true,
      width: SpacingManager.mainWidth(context) - 50,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getItem(
            onTap: () {
              if (restCompleteButton != null) { 
                restCompleteButton!();
              }
            },
            context: context,
            svgPath: getRightIcon(),
            color: Colors.red,
          ),
          getItem(
            onTap: () {
              if (pausePlayButton != null) {
                pausePlayButton!();
              }
            },
            context: context,
            svgPath: getCenterIcon(),
            center: true,
            color: Colors.yellow,
          ),
          getItem(
            onTap: () {
              if (stopeButton != null) {
                stopeButton!();
              }
            },
            context: context,
            svgPath: UIAssetsManger.stopIcon,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  getRightIcon() {
    String path = '';
    path = isStudying ? UIAssetsManger.restIcon : UIAssetsManger.completeIcon;
    return path;
  }

  getCenterIcon() {
    String path = '';
    path = pasued ? UIAssetsManger.playIcon : UIAssetsManger.pauseIcon;
    return path;
  }

  getItem({
    required BuildContext context,
    required Color color,
    VoidCallback? onTap,
    bool center = false,
    String svgPath = UIAssetsManger.completeIcon,
  }) {
    return Expanded(
      child: InkResponse(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: center ? Theme.of(context).primaryColor : null,
            border: Border.all(width: 1, color: Theme.of(context).dividerColor),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              svgPath,
              height: 25,
              width: 25,
            ),
          ),
        ),
      ),
    );
  }
}

