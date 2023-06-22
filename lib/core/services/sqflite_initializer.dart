// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteInitializer {
  static final SqfliteInitializer _singleTone = SqfliteInitializer._internal();
  factory SqfliteInitializer() {
    return _singleTone;
  }
  SqfliteInitializer._internal();
  static Database? db;
  static Future<Database?> get getDataBase async {
    if (db == null) {
      db = await initDataBase();
      return db;
    } else {
      return db;
    }
  }

  static Future<Database?> initDataBase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "materials_lessons.db");
    Database? myDB = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE "UsersSessions" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date text NOT NULL, period INTEGER DEFAULT 0)''');
      },
    );

    return myDB;
  }
}
