import 'package:dartz/dartz.dart';
import 'package:done/core/injection_container.dart';
import 'package:done/features/start_studying/domain/entities/studying_session.dart';
import 'package:done/features/start_studying/domain/usecases/all_studying_sessions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../features/start_studying/domain/usecases/last_seven_days.dart';
part 'app_data_holder_state.dart';

class AppDataHolderCubit extends Cubit<AppDataHolderState> {
  AppDataHolderCubit() : super(AppDataHolderLoading());
  final AllStudyingSessions allStudyingSessions = instance();
  final LastSevenDaysStudyingSessionsUseCase lastStudyingSessions =
      instance<LastSevenDaysStudyingSessionsUseCase>();
  List<StudyingSession> lastSevenSession = [];
  int fullSSessions = 0, fullSHours = 0;
  double avgSHoursPerDay = 0.0;
  init() async {
    List<StudyingSession> res = await allStudyingSessions.call();
    await initlastSevenSession(res);
    await initfullSSessions(res);
    await initfullSHours(res);
    await initAvgHourStudy(res);

    emit(AppDataHolderInitial(
        lastSevenSession: lastSevenSession,
        fullSSessions: fullSSessions,
        avgSHoursPerDay: avgSHoursPerDay,
        fullSHours: fullSHours));
  }

  initlastSevenSession(List<StudyingSession> allSessions) async {
    lastSevenSession = await lastStudyingSessions.call();
    return Future.value(unit);
  }

  initfullSSessions(List<StudyingSession> allSessions) async {
    fullSSessions = allSessions.length;
    return Future.value(unit);
  }

  initfullSHours(List<StudyingSession> allSessions) async {
    Duration d = Duration.zero;
    for (var element in allSessions) {
      d += element.period;
    }
    fullSHours = d.inHours;
    return Future.value(unit);
  }

  initAvgHourStudy(List<StudyingSession> res) {
    double count = 0;
    for (var r in res) {
      count += r.period.inHours;
    }
    avgSHoursPerDay = count / 7;
  }
}
