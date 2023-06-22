import '../entities/studying_session.dart';
import '../repositories/start_studying_repo.dart';

class DayStudyingSessions {
  final StartStudyingRepository repository;
  DayStudyingSessions(this.repository);
  Future<List<StudyingSession>> call() async {
    return await repository.dayStudyingSessions();
  }
}
