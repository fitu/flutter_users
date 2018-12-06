import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/db/dao.dart';
import 'package:flutter_random_user/repository/net/api_service.dart';

class Repository {
  var _apiService = ApiService();
  var _dao = DAO();

  static final Repository _instance = Repository.internal();

  factory Repository({apiService, dao}) {
    return _instance
      .._apiService = apiService
      .._dao = dao;
  }

  Repository.internal();

  Future<List<User>> getUsers() {
    return _apiService.getUsers();
  }

  Future<User> saveAsFavorite(User user) async {
    final tableUser = await _dao.tableUser;
    final newUser = User.copy(user: user, newValues: {User.IS_FAVORITE: true});
    await tableUser.addUser(newUser);
    return newUser;
  }

  Future<User> removeFromFavorite(User user) async {
    final tableUser = await _dao.tableUser;
    await tableUser.deleteUser(user.id);
    final newUser = User.copy(user: user, newValues: {User.IS_FAVORITE: false});
    return newUser;
  }

  Future<List<User>> loadFavorites() async {
    final tableUser = await _dao.tableUser;
    return tableUser.getAllUsers();
  }
}
