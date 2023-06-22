import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/functions/date_time.dart';
import '../../../../core/injection_container.dart';
import '../../../../core/services/sqflite_initializer.dart';
import '../../domain/entities/studying_session.dart';
import '../models/studying_session_model.dart';

abstract class StartStudyingLocalDataSource {
  Future<Unit> addStudyingSession(StudyingSessionModel studyingSession);
  Future<List<StudyingSession>> allStudyingSessions();

  Future<List<StudyingSession>> dayStudyingSessions();

  Future<StudyingSession> lastStudyingSessions();
  Future<List<StudyingSession>> laseSevenDays();
}

class StartStudyingLocalDataSourceImpl implements StartStudyingLocalDataSource {
  String dataKey = 'STUDYING_SESSIONS_KEY';
  SharedPreferences sp = instance();

  //
  @override
  Future<Unit> addStudyingSession(StudyingSessionModel studyingSession) async {
    debugPrint("addStudyingSession");
    Database? db = await SqfliteInitializer.getDataBase;
    if (db == null) return Future.value(unit);
    await db.insert("UsersSessions", studyingSession.toMap());
    return Future.value(unit);
  }

  @override
  Future<List<StudyingSession>> allStudyingSessions() async {
    Database? db = await SqfliteInitializer.getDataBase;
    if (db == null) throw Exception();
    List<Map> response = await db.query("UsersSessions");
    var finalData = List.generate(response.length, (index) {
      return StudyingSessionModel.fromJson(response[index]);
    });
    return Future.value(finalData);
  }

  @override
  Future<List<StudyingSession>> dayStudyingSessions() async {
    Database? db = await SqfliteInitializer.getDataBase;
    if (db == null) throw Exception();
    String sql = '''SELECT * FROM UsersSessions''';
    List<Map> response = await db.rawQuery(sql);
    var finalData = List.generate(response.length, (index) {
      return StudyingSessionModel.fromJson(response[index]);
    });
    return Future.value(
        finalData.where((element) => filterDates(element.date, 24)).toList());
  }

  @override
  Future<StudyingSession> lastStudyingSessions() async {
    Database? db = await SqfliteInitializer.getDataBase;
    if (db == null) throw Exception();
    String sql = '''SELECT * FROM UsersSessions''';
    List<Map> response = await db.rawQuery(sql);
    var finalData = List.generate(response.length, (index) {
      return StudyingSessionModel.fromJson(response[index]);
    });
    return Future.value(finalData.last);
  }

  @override
  Future<List<StudyingSession>> laseSevenDays() async {
    List<StudyingSession> all = await allStudyingSessions();
    all.sort((a, b) => a.date.compareTo(b.date));
    Set<DateTime> dates = {};
    for (var ss in all) {
      ss.date = DateTime(ss.date.year, ss.date.month, ss.date.day);
      dates.add(ss.date);
    }
    List<StudyingSession> finalList = [];
    for (var ss in dates) {
      finalList.add(getAllSesstionsWithSameDate(all, ss));
    }
    for (int i = finalList.length; i < (7); i++) {
      finalList
          .add(StudyingSession(period: Duration.zero, date: DateTime.now()));
    }
    return finalList;
  }

  StudyingSession getAllSesstionsWithSameDate(
      List<StudyingSession> list, DateTime date) {
    StudyingSession value = StudyingSession(period: Duration.zero, date: date);
    for (var l in list) {
      if (l.date.year == date.year &&
          l.date.month == date.month &&
          l.date.day == date.day) {
        value.period += l.period;
      }
    }
    return value;
  }
}
