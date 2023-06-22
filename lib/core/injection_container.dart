import 'package:done/features/start_studying/domain/usecases/last_seven_days.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/start_studying/data/datasources/local_datasource.dart';
import '../features/start_studying/data/repositories/start_studying_impl.dart';
import '../features/start_studying/domain/repositories/start_studying_repo.dart';
import '../features/start_studying/domain/usecases/add_studying_session.dart';
import '../features/start_studying/domain/usecases/all_studying_sessions.dart';
import '../features/start_studying/domain/usecases/day_studying_sessions.dart';
import '../features/start_studying/domain/usecases/last_studying_session.dart';

final instance = GetIt.instance;
getInit() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  instance.registerFactory<SharedPreferences>(() => sharedPreferences);
  // funcitons
  await getStartStudyingInstances();
}

getStartStudyingInstances() {
  //! Usecases
  instance.registerFactory<AllStudyingSessions>(
      () => AllStudyingSessions(instance()));
  instance.registerFactory<DayStudyingSessions>(
      () => DayStudyingSessions(instance()));
  instance.registerFactory<AddStudyingSession>(
      () => AddStudyingSession(instance()));
  instance.registerFactory<LastStudyingSessions>(
      () => LastStudyingSessions(instance()));
  instance.registerFactory<LastSevenDaysStudyingSessionsUseCase>(
      () => LastSevenDaysStudyingSessionsUseCase(instance()));

  //! Repository
  instance.registerFactory<StartStudyingRepository>(
      () => StartStudyingRepositoryImplement(instance()));
  //! Datasources
  instance.registerFactory<StartStudyingLocalDataSource>(
      () => StartStudyingLocalDataSourceImpl());
}
