import 'package:flutter_random_user/model/user.dart';

class UserEvent {}

class LoadUsers extends UserEvent {}

class AddUserToFavorites extends UserEvent {
  final User user;

  AddUserToFavorites(this.user);
}

class RemoveUserFromFavorites extends UserEvent {
  final User user;

  RemoveUserFromFavorites(this.user);
}

class LoadFavoriteUsers extends UserEvent {}

class SwapRenderMode extends UserEvent {}
