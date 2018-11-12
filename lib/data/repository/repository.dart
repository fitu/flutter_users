import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/data/repository/net/api_service.dart';

class Repository {
  static final Repository _instance = Repository.internal();

  factory Repository() => _instance;

  final _apiService = ApiService();

  Repository.internal();

  Stream<UserState> getUsers() {
    return _apiService.getUsers();
  }
}
