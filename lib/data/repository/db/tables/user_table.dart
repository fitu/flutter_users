import 'dart:async';

import 'package:flutter_random_user/model/user.dart';
import 'package:sqflite/sqflite.dart';

class TableFavoriteUser {
  static const String TABLE_NAME = 'FavoriteUser';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_FIRST_NAME = 'firstName';
  static const String COLUMN_LAST_NAME = 'lastName';
  static const String COLUMN_PICTURE = 'picture';

  final Future<Database> _db;

  TableFavoriteUser(this._db);

  Future create() async {
    var db = await _db;
    if (Sqflite.firstIntValue(
            await db.rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = '$TABLE_NAME'")) ==
        1) {
      print('Table already exists!');
      return;
    }
    await db.execute(
        'CREATE TABLE Users($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_FIRST_NAME TEXT, $COLUMN_LAST_NAME TEXT, $COLUMN_PICTURE TEXT)');
    print('Users table created :)');
  }

  Future<bool> existsTable() async {
    var db = await _db;
    return Sqflite.firstIntValue(
            await db.rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = '$TABLE_NAME'")) ==
        1;
  }

  Future<List<User>> getAllUsers() async {
    var db = await _db;
    var result = await db.query(TABLE_NAME, columns: [COLUMN_ID, COLUMN_FIRST_NAME, COLUMN_LAST_NAME, COLUMN_PICTURE]);
    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> addUser(User user) async {
    var db = await _db;
    var result = await db.insert(TABLE_NAME, user.toJson());
    return result;
  }

  Future<int> deleteUser(int id) async {
    var db = await _db;
    return await db.delete(TABLE_NAME, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }
}
