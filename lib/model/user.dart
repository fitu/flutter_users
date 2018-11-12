import 'package:meta/meta.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String picture;
  final String email;
  final String phone;

  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    this.picture = '',
    this.email = '',
    this.phone = '',
  });
}
