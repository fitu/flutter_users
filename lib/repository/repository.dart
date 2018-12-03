import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/db/dao.dart';
import 'package:flutter_random_user/repository/net/api_service.dart';

class Repository {
  static final Repository _instance = Repository.internal();

  factory Repository() => _instance;

  final _apiService = ApiService();
  final _dao = DAO();

  Repository.internal();

  Future<List<User>> getUsers() {
    return _apiService.getUsers();
  }

  Future<User> saveAsFavorite(User user) async {
    final tableUser = await _dao.tableUser;
    final User newUser = User.copy(user: user, newValues: {User.IS_FAVORITE: true});
    await tableUser.addUser(newUser);
    return newUser;
  }

  Future<User> removeFromFavorite(User user) async {
    final tableUser = await _dao.tableUser;
    await tableUser.deleteUser(user.id);
    return User.copy(user: user, newValues: {User.IS_FAVORITE: false});
  }

  Future<List<User>> loadFavorites() async {
    final tableUser = await _dao.tableUser;
    return tableUser.getAllUsers();
  }
}
