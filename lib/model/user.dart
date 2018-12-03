import 'package:flutter_random_user/repository/parser/user_parser.dart';
import 'package:meta/meta.dart';

class User {
  static const String ID = 'id';
  static const String FIRST_NAME = 'firstName';
  static const String LAST_NAME = 'lastName';
  static const String PICTURE = 'picture';
  static const String EMAIL = 'email';
  static const String PHONE = 'phone';
  static const String IS_FAVORITE = 'favorite';

  final String id;
  final String firstName;
  final String lastName;
  final String picture;
  final String email;
  final String phone;
  final int favorite;

  bool get isFavorite => favorite == 1 ? true : false;

  User(
      {@required this.id,
      @required this.firstName,
      @required this.lastName,
      this.picture = '',
      this.email = '',
      this.phone = '',
      this.favorite = 0});

  factory User.copy({@required User user, @required Map<String, dynamic> newValues}) {
    Map<String, dynamic> map = UserParser.toMap(user);
    newValues.forEach((key, value) {
      map[key] = value;
      if (key == IS_FAVORITE) {
        map[key] = value ? 1 : 0;
      }
    });
    return UserParser.fromMap(map);
  }

  @override
  String toString() {
    return 'id: $id - name: $firstName - isFavorite: $favorite';
  }
}
