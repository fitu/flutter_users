import 'package:flutter_random_user/model/user.dart';
import 'package:meta/meta.dart';

class UserState {
  final bool isLoading;
  final String errorMessage;
  final bool isList;
  final List<User> users;

  UserState({
    @required this.isLoading,
    @required this.errorMessage,
    @required this.isList,
    @required this.users,
  });

  factory UserState.loading() => UserState(isLoading: true, errorMessage: null, isList: null, users: null);

  factory UserState.notFound() => UserState(isLoading: false, errorMessage: null, isList: null, users: null);

  factory UserState.error(String errorMessage) =>
      UserState(isLoading: false, errorMessage: errorMessage, isList: null, users: null);

  factory UserState.success(List<User> users) =>
      UserState(isLoading: false, errorMessage: null, isList: null, users: users);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage &&
          isList == other.isList &&
          users == other.users;

  @override
  int get hashCode => isLoading.hashCode ^ errorMessage.hashCode ^ isList.hashCode ^ users.hashCode;
}
