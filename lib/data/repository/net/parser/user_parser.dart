import 'package:flutter_random_user/model/user.dart';

class UserParser {
  static List<User> fromJson(Map json) {
    final results = json['results'];

    final List<User> users = [];
    results.forEach((user) {
      final Map<String, dynamic> map = {};
      map['id'] = user['id']['value'];
      map['firstName'] = user['name']['first'];
      map['lastName'] = user['name']['last'];
      map['picture'] = user['picture']['medium'];

      users.add(User.fromJson(map));
    });
    return users;
  }
}
