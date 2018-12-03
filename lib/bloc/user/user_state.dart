import 'package:flutter_random_user/model/user.dart';
import 'package:meta/meta.dart';

class UserState {
  final bool isLoading;
  final Error throwable;
  final bool isList;
  final List<User> users;
  final User user;

  UserState({
    @required this.isLoading,
    @required this.throwable,
    @required this.isList,
    @required this.users,
    @required this.user,
  });

  factory UserState.initial() => UserState(isLoading: false, throwable: null, isList: null, users: null, user: null);

  factory UserState.notFound() => UserState(isLoading: false, throwable: null, isList: null, users: null, user: null);

  factory UserState.loading() => UserState(isLoading: true, throwable: null, isList: null, users: null, user: null);

  factory UserState.error(Error throwable) =>
      UserState(isLoading: false, throwable: throwable, isList: null, users: null, user: null);

  factory UserState.success(List<User> users) =>
      UserState(isLoading: false, throwable: null, isList: null, users: users, user: null);

  factory UserState.swapFavorite(User user) =>
      UserState(isLoading: false, throwable: null, isList: null, users: null, user: user);
}
