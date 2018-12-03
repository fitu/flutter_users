import 'dart:async';
import 'dart:convert';

import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/net/api.dart';
import 'package:flutter_random_user/repository/parser/user_parser.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(Api.URL_GET_USERS));
    return UserParser.fromBE(json.decode(response.body));
  }
}
