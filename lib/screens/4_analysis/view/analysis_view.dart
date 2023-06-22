import 'package:done/core/injection_container.dart';
import 'package:done/core/resources/values_manager.dart';
import 'package:done/core/widgets/custom_container.dart';
import 'package:done/core/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../core/services/custom_paints.dart';
import '../../../cubit/cubit/app_data_holder_cubit.dart';
import '../../../features/start_studying/domain/entities/studying_session.dart';
import '../../../features/start_studying/domain/usecases/day_studying_sessions.dart';
import '../widgets/info_boxes_widget.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  @override
  void initState() {
    context.read<AppDataHolderCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("شاشة التحليلات"),
      ),
      body: BlocBuilder<AppDataHolderCubit, AppDataHolderState>(
        builder: (context, state) {
          if (state is AppDataHolderInitial) {
            return Column(
              children: [
                CustomContainer(
                  child: SizedBox(
                    height: SpacingManager.mainWidth(context) / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 17),
                      child: CustomPaint(
                        painter: ProgressIndecatorsPainter(
                            context: context,
                            data: state.lastSevenSession
                                .map((e) => e.period.inHours / 24)
                                .toList()),
                        child: Container(),
                      ),
                    ),
                  ),
                ),
                const MainSpacer(),
                InfoBoxesWidget(state: state),
                const MainSpacer(),
                const IndecatorWidget(),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}

class IndecatorWidget extends StatefulWidget {
  const IndecatorWidget({
    super.key,
  });

  @override
  State<IndecatorWidget> createState() => _IndecatorWidgetState();
}

class _IndecatorWidgetState extends State<IndecatorWidget> {
  double percent = 0.0;
  @override
  void initState() {
    getPercent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MainSpacer(),
          Text(
            "عدد الساعات الدراسية لليوم",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const MainSpacer(
            spacerType: SType.twiceMain,
          ),
          LinearPercentIndicator(
            padding: EdgeInsets.zero,
            isRTL: true,
            progressColor: Theme.of(context).primaryColor,
            percent: percent,
            barRadius: const Radius.circular(12),
          ),
          const MainSpacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ساعات الدراسة : ${(percent * 24).toInt()}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                "باقي ساعات اليوم : ${24 - (percent * 24).toInt()}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          )
        ],
      ),
    );
  }

  getPercent() async {
    List<StudyingSession> list = await instance<DayStudyingSessions>().call();
    int m = 0;
    for (var l in list) {
      m += l.period.inMinutes;
    }

    percent = (m / 60) / 24;

    setState(() {});
  }
}
