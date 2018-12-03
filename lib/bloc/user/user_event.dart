import 'package:flutter_random_user/model/user.dart';

abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class FavoritePressed extends UserEvent {
  final User user;

  FavoritePressed(this.user);
}
