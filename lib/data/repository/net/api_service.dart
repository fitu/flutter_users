import 'dart:async';
import 'dart:convert';

import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/data/repository/net/api.dart';
import 'package:flutter_random_user/data/repository/net/parser/user_parser.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Stream<UserState> getUsers() async* {
    yield LoadingUsers();
    try {
      final response = await http.get(Uri.parse(Api.URL_GET_USERS));
      List<User> users = UserParser.fromJson(json.decode(response.body));
      if (users.isEmpty) {
        yield NotFoundUsers();
      } else {
        yield SuccessUsers(users);
      }
    } catch (error) {
      yield ErrorUsers(error);
    }
  }
}
