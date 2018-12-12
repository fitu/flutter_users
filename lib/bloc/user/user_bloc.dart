import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_random_user/bloc/user/user_event.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  var repository;

  UserBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  UserState get initialState => UserState.loading();

  void loadUsers() async {
    dispatch(LoadUsers());
  }

  @override
  Stream<UserState> mapEventToState(UserState state, UserEvent event) async* {
    try {
      final users = await repository.getUsers();
      yield UserState.success(users);
    } on String catch (exception) {
      yield UserState.error(exception);
    } catch (exception) {
      yield UserState.error(exception.toString());
    }
  }

  Future<User> onFavoritePressed(FavoritePressed event) async {
    return event.user.isFavorite
        ? await repository.removeFromFavorite(event.user)
        : await repository.saveAsFavorite(event.user);
  }
}
