import '../entities/studying_session.dart';
import '../repositories/start_studying_repo.dart';

class LastSevenDaysStudyingSessionsUseCase {
  final StartStudyingRepository repository;
  LastSevenDaysStudyingSessionsUseCase(this.repository);
  Future<List<StudyingSession>> call() async {
    return await repository.laseSevenDays();
  }
}
