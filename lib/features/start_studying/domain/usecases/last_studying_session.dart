import '../entities/studying_session.dart';
import '../repositories/start_studying_repo.dart';

class LastStudyingSessions {
  final StartStudyingRepository repository;
  LastStudyingSessions(this.repository);
  Future<StudyingSession?> call() async {
    return await repository.lastStudyingSessions();
  }
}
