import 'dart:async';
import 'dart:convert';

import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/net/api.dart';
import 'package:flutter_random_user/repository/parser/user_parser.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService.internal();

  factory ApiService() => _instance;

  ApiService.internal();

  Future<List<User>> getUsers() async {
    final response = await http.get(Api.URL_GET_USERS);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserParser.fromBE(json.decode(response.body));
    }
    throw 'There was an error';
  }
}
