import 'package:flutter_random_user/model/user.dart';

class UserParser {
  static List<User> fromJson(Map json) {
    final List<dynamic> results = json['results'];

    return results.map(
      (userMap) {
        return User(
          id: userMap['id']['value'],
          firstName: userMap['name']['first'],
          lastName: userMap['name']['last'],
          picture: userMap['picture']['medium'],
        );
      },
    ).toList();
  }
}
