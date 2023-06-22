import 'package:flutter/material.dart';

import '../../../core/resources/values_manager.dart';
import '../../../core/services/custom_paints.dart';
import '../../../core/widgets/custom_container.dart';

class ProgressWidget extends StatefulWidget {
  const ProgressWidget({
    super.key,
    required this.percent,
    required this.passedTime,
    required this.subTitle,
  });
  final double percent;
  final Duration passedTime;
  final String subTitle;
  @override
  State<ProgressWidget> createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        height: SpacingManager.mainWidth(context),
        child: CustomPaint(
          painter: CircularTimeProgressIndecatorPainter(
              backGroundColor: Theme.of(context).dividerColor,
              progressColor: Theme.of(context).primaryColor,
              value: widget.percent,
              lineWidth: 15,
              titleStyle: Theme.of(context).textTheme.labelMedium,
              subTitleStyle: Theme.of(context).textTheme.labelLarge,
              title: widget.passedTime.toString().substring(2, 7),
              subTitle: widget.subTitle),
          child: Container(),
        ));
  }
}
