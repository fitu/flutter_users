import 'package:flutter_random_user/model/user.dart';

class UserState {}

class NotUsersFound extends UserState {}

class LoadingUsers extends UserState {}

class UsersError extends UserState {
  final Error error;

  UsersError(this.error);
}

class SuccessLoadingUsers extends UserState {
  final List<User> users;

  SuccessLoadingUsers(this.users);
}

class SwapFavoriteUser extends UserState {
  final User user;

  SwapFavoriteUser(this.user);
}

class FavoriteUsers extends UserState {
  final List<User> users;

  FavoriteUsers(this.users);
}

class SwapListType extends UserState {
  final List<User> users;
  final bool isList;

  SwapListType(this.users, this.isList);
}
