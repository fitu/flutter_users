import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/bloc_provider.dart';
import 'package:flutter_random_user/data/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/ui/pages/users_page.dart';

class UsersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: BlocProvider<UserBloc>(
        bloc: UserBloc(),
        child: UsersPage(),
      ),
    );
  }
}
