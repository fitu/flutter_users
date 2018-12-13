import 'package:flutter/material.dart';
import 'package:flutter_random_user/app_config.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/repository/net/api.dart';
import 'package:flutter_random_user/ui/pages/favorite/favorites_page.dart';
import 'package:flutter_random_user/ui/pages/user/users_page.dart';

class UsersApp extends StatelessWidget {
  final _userBloc = UserBloc();
  final _favoriteBloc = FavoriteBloc();

  @override
  Widget build(BuildContext context) {
    initialize(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
        '/': (BuildContext context) => UsersPage(_userBloc),
        '/favorites': (BuildContext context) => FavoritesPage(_favoriteBloc),
      },
    );
  }

  void initialize(BuildContext context) {
    Api.BASE_URL = AppConfig.of(context).baseUrl;
  }
}
