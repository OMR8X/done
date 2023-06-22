import '../../domain/entities/studying_session.dart';

class StudyingSessionModel extends StudyingSession {
  StudyingSessionModel({required super.period, required super.date});

  factory StudyingSessionModel.fromJson(Map data) {
    String date = data["date"].substring(0, 19);
    return StudyingSessionModel(
      period: Duration(seconds: data["period"]),
      date: DateTime.parse(date),
    );
  }
  factory StudyingSessionModel.fromBaseModel(StudyingSession data) {
    return StudyingSessionModel(
      period: data.period,
      date: data.date,
    );
  }
  toMap() {
    return {
      "period": period.inSeconds,
      "date": date.toString(),
    };
  }
}
