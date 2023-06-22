import 'package:done/core/resources/values_manager.dart';
import 'package:done/core/widgets/spacers.dart';
import 'package:done/screens/5_studying/cubit/cubit/studying_manager_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/progress_widget.dart';
import '../widgets/studying_controller_widgets.dart';

class StudyingView extends StatefulWidget {
  const StudyingView(
      {super.key,
      required this.isStudying,
      required this.paused,
      required this.percent,
      required this.passedTime});
  final bool isStudying;
  final bool paused;
  final double percent;
  final Duration passedTime;
  @override
  State<StudyingView> createState() => _StudyingViewState();
}

class _StudyingViewState extends State<StudyingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const MainSpacer(
            axisDirection: Axis.horizontal,
            spacerType: SType.inf,
          ),
          ProgressWidget(
            passedTime: widget.passedTime,
            subTitle: "مدة الدراسة",
            percent: widget.percent,
          ),
          const Spacer(),
          StudyingControllersWidget(
            isStudying: widget.isStudying,
            pasued: widget.paused,
            stopeButton: () {
              context.read<StudyingManagerCubit>().stop();
              Navigator.of(context).pop();
            },
            pausePlayButton: () {
              context.read<StudyingManagerCubit>().setPause(!widget.paused);
            },
            restCompleteButton: () {
              if (widget.isStudying) {
                context.read<StudyingManagerCubit>().startResting();
              } else {
                context.read<StudyingManagerCubit>().startStudying();
              }
            },
          ),
          const SizedBox(height: SpacingManager.topSpace / 2)
        ],
      ),
    );
  }
}
