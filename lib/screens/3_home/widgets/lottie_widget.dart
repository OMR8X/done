import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/widgets/custom_container.dart';



class HomeViewLottieWidget extends StatelessWidget {
  const HomeViewLottieWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: LottieBuilder.asset(
        LottieManager.studenWithGlasses,
        filterQuality: FilterQuality.low,
      ),
    );
  }
}
