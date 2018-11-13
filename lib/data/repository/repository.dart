import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/data/repository/db/dao.dart';
import 'package:flutter_random_user/data/repository/net/api_service.dart';
import 'package:flutter_random_user/model/user.dart';

class Repository {
  static final Repository _instance = Repository.internal();

  factory Repository() => _instance;

  final _apiService = ApiService();
  final _dao = DAO();

  Repository.internal();

  Stream<UserState> getUsers() {
    return _apiService.getUsers();
  }

  Stream<User> saveAsFavorite(User user) async* {
    final tableUser = await _dao.tableUser;
    final User newUser = User.copy(user: user, newValues: {User.IS_FAVORITE: true});
    final int result = await tableUser.addUser(newUser);
    if (result < 1) {
      yield user;
    } else {
      yield newUser;
    }
  }

  Stream<User> removeFromFavorite(User user) async* {
    final tableUser = await _dao.tableUser;
    final int result = await tableUser.deleteUser(user.id);
    final User newUser = User.copy(user: user, newValues: {User.IS_FAVORITE: false});
    if (result < 1) {
      yield user;
    } else {
      yield newUser;
    }
  }

  Stream<UserState> loadFavorites() async* {
    final tableUser = await _dao.tableUser;
    final List<User> users = await tableUser.getAllUsers();
    if (users.isEmpty) {
      yield NotUsersFound();
    } else {
      yield FavoriteUsers(users);
    }
  }
}
