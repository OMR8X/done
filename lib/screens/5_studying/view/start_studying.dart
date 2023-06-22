import 'package:done/screens/5_studying/view/end_session_view.dart';
import 'package:done/screens/5_studying/view/resting_view.dart';
import 'package:done/screens/5_studying/view/session_setting_view.dart';
import 'package:done/screens/5_studying/view/studying_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit/studying_manager_cubit.dart';

class StartStudyingView extends StatefulWidget {
  const StartStudyingView({super.key});
  @override
  State<StartStudyingView> createState() => _StartStudyingViewState();
}

class _StartStudyingViewState extends State<StartStudyingView> {
  @override
  void initState() {
    if (context.read<StudyingManagerCubit>().studyingPeriod == Duration.zero) {
      context.read<StudyingManagerCubit>().stop();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudyingManagerCubit, StudyingManagerState>(
      builder: (context, state) {
        if (state is StudyingManagerInitial) {
          return const SessionSettingView();
        } else if (state is StudyingManagerResting) {
          return const RestingView();
        } else if (state is StudyingManagerTimeUp) {
          return const EndSessionView();
        } else if (state is StudyingManagerStudying) {
          return StudyingView(
            percent: state.progressP,
            isStudying: true,
            paused: state.pause,
            passedTime: state.passedTime,
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        );
      },
    );
  }
}
