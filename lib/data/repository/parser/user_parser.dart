import 'dart:math';

import 'package:flutter_random_user/model/user.dart';

class UserParser {
  static List<User> fromBE(Map json) {
    final List<dynamic> results = json['results'];

    return results.map(
      (userMap) {
        final String id = Random().nextInt(10000).toString();
        return User(
          id: id,
          firstName: userMap['name']['first'],
          lastName: userMap['name']['last'],
          picture: userMap['picture']['medium'],
        );
      },
    ).toList();
  }

  static Map toBE(List<User> users) => {};

  static User fromMap(Map<String, dynamic> map) {
    return User(
        id: map[User.ID],
        firstName: map[User.FIRST_NAME],
        lastName: map[User.LAST_NAME],
        picture: map[User.PICTURE],
        email: map[User.EMAIL],
        phone: map[User.PHONE],
        favorite: map[User.IS_FAVORITE]);
  }

  static Map<String, dynamic> toMap(User user) {
    return {
      User.ID: user.id,
      User.FIRST_NAME: user.firstName,
      User.LAST_NAME: user.lastName,
      User.PICTURE: user.picture,
      User.EMAIL: user.email,
      User.PHONE: user.phone,
      User.IS_FAVORITE: user.isFavorite ? 1 : 0
    };
  }
}
