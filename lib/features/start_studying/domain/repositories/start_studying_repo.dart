import 'package:dartz/dartz.dart';
import '../../data/models/studying_session_model.dart';
import '../entities/studying_session.dart';

abstract class StartStudyingRepository {
  //
  Future<List<StudyingSession>> allStudyingSessions();
  Future<StudyingSession?> lastStudyingSessions();
  Future<List<StudyingSession>> dayStudyingSessions();
  //
  Future<Unit> addStudyingSession(StudyingSessionModel studyingSession);
  //
  Future<List<StudyingSession>> laseSevenDays();
}
