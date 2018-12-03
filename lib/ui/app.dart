import 'package:flutter/material.dart';
import 'package:flutter_random_user/ui/pages/favorite/favorites_page.dart';
import 'package:flutter_random_user/ui/pages/user/users_page.dart';

class UsersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      routes: {
        '/': (BuildContext context) => UsersPage(),
        '/favorites': (BuildContext context) => FavoritesPage(),
      },
    );
  }
}
