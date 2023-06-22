import '../../Features/start_studying/data/models/studying_session_model.dart';
import '../../Features/start_studying/domain/entities/studying_session.dart';

mergDateTimes(List<StudyingSession> dateTimes) {
  Map<DateTime, Duration> data = {};
  for (var studyingSession in dateTimes) {
    DateTime d = resetDateTime(dateTime: studyingSession.date, subCount: 10);
    data[d] = (data[d] ?? const Duration(seconds: 0)) + studyingSession.period;
  }
  List<StudyingSessionModel> finalData = [];
  data.forEach((key, value) {
    finalData.add(StudyingSessionModel(period: value, date: key));
  });
  return finalData;
}

bool filterDates(DateTime a, int? rangeInHours) {
  rangeInHours = rangeInHours ?? 24;
  a = resetDateTime(dateTime: a, subCount: 10);
  DateTime b = resetDateTime(dateTime: DateTime.now(), subCount: 10);

  if (a.difference(b).inHours.abs() < rangeInHours) return true;
  return false;
}

resetDateTime({required DateTime dateTime, int subCount = 19}) {
  String a = dateTime.toString().substring(0, subCount);
  return DateTime.parse(a);
}
