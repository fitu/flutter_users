import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_event.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_state.dart';
import 'package:flutter_random_user/repository/repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  var repository;
  bool isList = true;

  FavoriteBloc({this.repository}) {
    this.repository = repository != null ? repository : Repository();
  }

  FavoriteState get initialState => FavoriteState.initial();

  void loadFavorites() => dispatch(LoadFavorites());

  void swapRenderMode() => dispatch(SwapRenderMode());

  @override
  Stream<FavoriteState> mapEventToState(FavoriteState state, FavoriteEvent event) async* {
    if (event is LoadFavorites) {
      final users = await repository.loadFavorites();
      yield FavoriteState.favorites(users);
    }

    if (event is SwapRenderMode) {
      final users = await repository.loadFavorites();
      isList = !isList;
      yield FavoriteState.swapList(users, isList);
    }
  }
}
