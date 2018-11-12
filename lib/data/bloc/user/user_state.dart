import 'package:flutter_random_user/model/user.dart';

class UserState {}

class NotFoundUsers extends UserState {}

class LoadingUsers extends UserState {}

class ErrorUsers extends UserState {
  final Exception exception;

  ErrorUsers(this.exception);
}

class SuccessUsers extends UserState {
  final List<User> users;

  SuccessUsers(this.users);
}
