import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

@JsonSerializable()
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

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
