import 'package:dartz/dartz.dart';
import '../../domain/entities/studying_session.dart';
import '../../domain/repositories/start_studying_repo.dart';
import '../datasources/local_datasource.dart';
import '../models/studying_session_model.dart';

class StartStudyingRepositoryImplement implements StartStudyingRepository {
  final StartStudyingLocalDataSource localDataSource;

  StartStudyingRepositoryImplement(this.localDataSource);
  @override
  Future<Unit> addStudyingSession(StudyingSessionModel studyingSession) {
    localDataSource.addStudyingSession(studyingSession);
    return Future.value(unit);
  }

  @override
  Future<List<StudyingSession>> allStudyingSessions(
      {bool mergDates = true}) async {
    List<StudyingSession> data = await localDataSource.allStudyingSessions();
    return data;
  }

  @override
  Future<List<StudyingSession>> dayStudyingSessions() async {
    List<StudyingSession> data = await localDataSource.dayStudyingSessions();
    return data;
  }

  @override
  Future<StudyingSession?> lastStudyingSessions() async {
    StudyingSession? data = await localDataSource.lastStudyingSessions();
    return data;
  }

  @override
  Future<List<StudyingSession>> laseSevenDays() async {
    List<StudyingSession> data = await localDataSource.laseSevenDays();
    return data;
  }
}
