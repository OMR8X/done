import 'dart:async';

import 'package:done/core/injection_container.dart';
import 'package:done/features/start_studying/data/models/studying_session_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/start_studying/domain/usecases/add_studying_session.dart';
part 'studying_manager_state.dart';

class StudyingManagerCubit extends Cubit<StudyingManagerState> {
  StudyingManagerCubit() : super(StudyingManagerInitial());
  //bool
  bool isResting = false;
  bool isPaused = false;
  Timer? _timer;
  AddStudyingSession addStudyingSession = instance();
  //duration
  Duration studyingPeriod = Duration.zero;
  Duration restingPeriod = Duration.zero;
  Duration studyingPassedTimer = Duration.zero;
  //double
  double progressP = 0.0;
  //
  stop() async {
    emit(StudyingManagerLoading());
    await reset();
    emit(StudyingManagerInitial());
  }

  reset() async {
    exitTimer();
    var d = StudyingSessionModel(period: studyingPeriod, date: DateTime.now());
    await addStudyingSession.call(studyingSession: d);
    isResting = false;
    isPaused = false;
    studyingPeriod = Duration.zero;
    restingPeriod = Duration.zero;
    studyingPassedTimer = Duration.zero;
    progressP = 0.0;
    return;
  }

  timeUp() async {
    emit(StudyingManagerLoading());
    await reset();
    emit(StudyingManagerTimeUp());
  }

  setPause(bool value) {
    isPaused = value;
    emitState();
  }

  initTime(Duration value) {
    studyingPeriod = value;
  }

  //
  startStudying() async {
    emit(StudyingManagerLoading());
    exitTimer();
    isResting = false;
    isPaused = false;
    //start timer
    initTimer();
  }

  //
  startResting() async {
    emit(StudyingManagerLoading());
    setPause(true);
    isResting = true;
    emit(StudyingManagerResting());
  }

  //
  onTimeTick() {
    increaseTimeCounters();
    emitState();
  }

  //
  increaseTimeCounters() {
    if (isPaused) return;
    double value =
        (studyingPassedTimer.inSeconds + 1) / studyingPeriod.inSeconds;
    if (value > 1) {
      timeUp();
      return;
    }
    progressP = value;
    studyingPassedTimer += const Duration(seconds: 1);
  }

  emitState() {
    if (isResting) {
      emit(StudyingManagerResting());
    } else {
      emit(StudyingManagerStudying(
          pause: isPaused,
          progressP: progressP,
          passedTime: studyingPassedTimer));
    }
  }

  //
  //
  initTimer() {
    if (_timer != null) {
      _timer = null;
    }
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => onTimeTick());
  }

  exitTimer() {
    if (_timer == null) return;
    if (_timer!.isActive) _timer!.cancel();
    _timer = null;
  }
}
