import 'package:flutter_random_user/model/user.dart';
import 'package:meta/meta.dart';

class FavoriteState {
  final bool isList;
  final List<User> users;

  FavoriteState({
    @required this.isList,
    @required this.users,
  });

  factory FavoriteState.initial() => FavoriteState(isList: null, users: null);

  factory FavoriteState.favorites(List<User> users) => FavoriteState(isList: null, users: users);

  factory FavoriteState.swapList(List<User> users, bool isList) => FavoriteState(isList: isList, users: users);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteState && runtimeType == other.runtimeType && isList == other.isList && users == other.users;

  @override
  int get hashCode => isList.hashCode ^ users.hashCode;
}
