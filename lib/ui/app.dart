import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/bloc_provider.dart';
import 'package:flutter_random_user/ui/pages/users_page.dart';

class UsersApp extends StatefulWidget {
  @override
  State createState() => _UsersAppState();
}

class _UsersAppState extends State<UsersApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: UsersPage(),
      ),
    );
  }
}
