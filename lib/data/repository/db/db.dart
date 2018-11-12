import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String DB_NAME = 'database_favorite_users.db';

  static final DBHelper _instance = DBHelper.internal();

  factory DBHelper() => _instance;

  static Database _db;

  DBHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DB_NAME);
    var db = await openDatabase(path, version: 1);
    return db;
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
