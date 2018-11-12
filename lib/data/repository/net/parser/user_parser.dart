import 'package:flutter_random_user/model/user.dart';

class UserParser {
  static List<User> fromJson(Map json) {
    final results = json['results'];

    return results.map((user) {
      final Map<String, dynamic> map = {};
      map['id'] = user['id']['value'];
      map['firstName'] = user['name']['first'];
      map['lastName'] = user['name']['last'];
      map['picture'] = user['picture']['medium'];
      return map;
    }).toList();
  }
}
