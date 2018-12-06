import 'package:flutter_random_user/repository/db/db.dart';
import 'package:flutter_random_user/repository/db/tables/user_table.dart';

class DAO {
  DBHelper helper;
  TableFavoriteUser _tableUser;

  static final DAO _instance = DAO.internal();

  factory DAO() => _instance;

  DAO.internal() {
    helper = DBHelper();
  }

  Future<TableFavoriteUser> get tableUser async {
    if (_tableUser == null) {
      _tableUser = await createTableUser();
    }
    return _tableUser;
  }

  Future<TableFavoriteUser> createTableUser() async {
    var tableUser = TableFavoriteUser(helper.db);
    await tableUser.create();
    return tableUser;
  }

  void close() {
    helper.close();
  }
}
