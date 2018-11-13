import 'dart:async';

import 'package:flutter_random_user/data/bloc/base_bloc.dart';
import 'package:flutter_random_user/data/bloc/user/user_event.dart';
import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/data/repository/repository.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc implements BaseBloc {
  final Repository _repository = Repository();
  bool isList = true;

  final ReplaySubject<UserEvent> _userSubject = ReplaySubject<UserEvent>();
  Stream<UserState> _outState = Stream.empty();

  Stream<UserState> get outState => _outState;

  Sink<UserEvent> get inEvents => _userSubject;

  UserBloc() {
    _outState = _userSubject.switchMap<UserState>(
      (event) {
        if (event is LoadUsers) {
          return _repository.getUsers();
        }
        if (event is LoadFavoriteUsers) {
          return _repository.loadFavorites();
        }
        if (event is SwapRenderMode) {
          return _repository.loadFavorites().map(
            (state) {
              if (state is FavoriteUsers) {
                isList = !isList;
                return SwapListType(state.users, isList);
              }
              return state;
            },
          );
        }
      },
    );
  }

  Future<User> asFavorite(User user) {
    return user.isFavorite ? _repository.removeFromFavorite(user).first : _repository.saveAsFavorite(user).first;
  }

  @override
  void dispose() {
    _userSubject.close();
  }
}
