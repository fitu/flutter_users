import 'package:flutter_random_user/model/user.dart';
import 'package:meta/meta.dart';

class UserState {
  final bool isLoading;
  final Error throwable;
  final bool isList;
  final List<User> users;

  UserState({
    @required this.isLoading,
    @required this.throwable,
    @required this.isList,
    @required this.users,
  });

  factory UserState.loading() => UserState(isLoading: true, throwable: null, isList: null, users: null);

  factory UserState.notFound() => UserState(isLoading: false, throwable: null, isList: null, users: null);

  factory UserState.error(Error throwable) =>
      UserState(isLoading: false, throwable: throwable, isList: null, users: null);

  factory UserState.success(List<User> users) =>
      UserState(isLoading: false, throwable: null, isList: null, users: users);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          throwable == other.throwable &&
          isList == other.isList &&
          users == other.users;

  @override
  int get hashCode => isLoading.hashCode ^ throwable.hashCode ^ isList.hashCode ^ users.hashCode;
}
