import 'package:flutter_random_user/data/repository/net/api_service.dart';
import 'package:flutter_random_user/model/user.dart';

class UserBloc {
  final ApiService _apiService = ApiService();
  Stream<List<User>> _results = Stream.empty();

  Stream<List<User>> get results => _results;

  void getUsers() {
    _results = _apiService.getUsers().asStream();
  }
}
