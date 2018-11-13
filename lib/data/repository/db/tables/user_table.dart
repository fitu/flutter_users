import 'dart:async';

import 'package:flutter_random_user/data/repository/parser/user_parser.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:sqflite/sqflite.dart';

class TableFavoriteUser {
  static const String TABLE_NAME = 'FavoriteUser';
  static const String COLUMN_ID = User.ID;
  static const String COLUMN_FIRST_NAME = User.FIRST_NAME;
  static const String COLUMN_LAST_NAME = User.LAST_NAME;
  static const String COLUMN_PICTURE = User.PICTURE;
  static const String COLUMN_EMAIL = User.EMAIL;
  static const String COLUMN_PHONE = User.PHONE;
  static const String COLUMN_IS_FAVORITE = User.IS_FAVORITE;

  final Future<Database> _db;

  TableFavoriteUser(this._db);

  Future create() async {
    var db = await _db;
    if (Sqflite.firstIntValue(
            await db.rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = '$TABLE_NAME'")) ==
        1) {
      print('Table $TABLE_NAME already exists!');
      return;
    }
    await db.execute(
        'CREATE TABLE $TABLE_NAME($COLUMN_ID TEXT PRIMARY KEY, $COLUMN_FIRST_NAME TEXT, $COLUMN_LAST_NAME TEXT, '
        '$COLUMN_PICTURE TEXT, $COLUMN_EMAIL TEXT, $COLUMN_PHONE TEXT, $COLUMN_IS_FAVORITE INTEGER)');
    print('Table $TABLE_NAME created :)');
  }

  Future<bool> existsTable() async {
    var db = await _db;
    return Sqflite.firstIntValue(
            await db.rawQuery("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name = '$TABLE_NAME'")) ==
        1;
  }

  Future<List<User>> getAllUsers() async {
    var db = await _db;
    var result = await db.query(TABLE_NAME, columns: [
      COLUMN_ID,
      COLUMN_FIRST_NAME,
      COLUMN_LAST_NAME,
      COLUMN_PICTURE,
      COLUMN_EMAIL,
      COLUMN_PHONE,
      COLUMN_IS_FAVORITE
    ]);
    return result.map((map) => UserParser.fromMap(map)).toList();
  }

  Future<int> addUser(User user) async {
    var db = await _db;
    return await db.insert(TABLE_NAME, UserParser.toMap(user));
  }

  Future<int> deleteUser(String id) async {
    var db = await _db;
    return await db.delete(TABLE_NAME, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }
}
