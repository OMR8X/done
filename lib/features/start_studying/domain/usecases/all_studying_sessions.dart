import '../entities/studying_session.dart';
import '../repositories/start_studying_repo.dart';

class AllStudyingSessions {
  final StartStudyingRepository repository;
  AllStudyingSessions(this.repository);
  Future<List<StudyingSession>> call() async {
    return await repository.allStudyingSessions();
  }
}
