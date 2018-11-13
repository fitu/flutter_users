import 'package:flutter_random_user/model/user.dart';
import 'dart:math';

class UserParser {
  static List<User> fromJson(Map json) {
    final List<dynamic> results = json['results'];

    return results.map(
      (userMap) {
        final String id = Random().nextInt(10000).toString();
        return User(
          id: userMap['id']['value'] != null ? userMap['id']['value'] : Random().nextInt(10000).toString(),
          firstName: userMap['name']['first'],
          lastName: userMap['name']['last'],
          picture: userMap['picture']['medium'],
        );
      },
    ).toList();
  }
}
