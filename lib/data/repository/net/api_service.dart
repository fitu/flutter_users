import 'dart:async';
import 'dart:convert';

import 'package:flutter_random_user/data/repository/net/api.dart';
import 'package:flutter_random_user/data/repository/net/parser/user_parser.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(Api.URL_GET_USERS));
    return UserParser.fromJson(json.decode(response.body));
  }
}
