import 'package:done/cubit/cubit/app_data_holder_cubit.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/values_manager.dart';
import '../../../core/widgets/custom_container.dart';

class InfoBoxesWidget extends StatelessWidget {
  const InfoBoxesWidget({
    super.key, required this.state,
  });
  final AppDataHolderInitial state;
  @override
  Widget build(BuildContext context) {
 
    // print("avgSHoursPerDay: ${reader.avgSHoursPerDay}");
    // print("fullSHours: ${reader.fullSHours}");
    debugPrint("fullSSessions: ${state.fullSSessions}");
    return SizedBox(
      width: SpacingManager.mainWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getItem(context, state.fullSSessions.toString(),
              "كامل الجلسات الدراسية"),
          getItem(context, state.avgSHoursPerDay.toStringAsPrecision(1),
              "متوسط ساعات الدراسة أسبوعيا"),
          getItem(context, state.fullSHours.toString(), "كامل ساعات الدراسة"),
        ],
      ),
    );
  }

  getItem(BuildContext context, String title, subtitle) {
    double width = SpacingManager.dividWidth(context, 3);
    double height = width + 10;
    return CustomContainer(
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //
          SizedBox(
            height: height / 3,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          //
          const Divider(
            height: 1,
            thickness: 2,
          ),
          //

          SizedBox(
            height: height / 3,
            child: Center(
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
