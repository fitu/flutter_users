import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_random_user/bloc/user/user_event.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/repository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Repository _repository;

  UserBloc(this._repository);

  UserState get initialState => UserState.initial();

  void loadUsers() {
    dispatch(LoadUsers());
  }

  @override
  Stream<UserState> mapEventToState(UserState state, UserEvent event) async* {
    yield UserState.loading();
    try {
      final users = await _repository.getUsers();
      yield UserState.success(users);
    } catch (error) {
      yield UserState.error(error);
    }
  }

  Future<User> onFavoritePressed(FavoritePressed event) async {
    return event.user.isFavorite
        ? await _repository.removeFromFavorite(event.user)
        : await _repository.saveAsFavorite(event.user);
  }
}
