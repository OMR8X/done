import 'package:dartz/dartz.dart';
import '../../data/models/studying_session_model.dart';
import '../repositories/start_studying_repo.dart';

class AddStudyingSession {
  final StartStudyingRepository repository;
  AddStudyingSession(this.repository);
  Future<Unit> call({required StudyingSessionModel studyingSession}) async {
    return await repository.addStudyingSession(studyingSession);
  }
}
