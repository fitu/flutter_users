import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/repository/net/parser/user_parser.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  static const String URL = 'https://randomuser.me/api/?results=10';
  List<User> _users;

  @override
  void initState() {
    doRequest();
    super.initState();
  }

  Future<void> doRequest() async {
    final response = await http.get(URL);
    setState(() {
      var body = json.decode(response.body);
      _users = UserParser.fromJson(body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random User',
      home: Scaffold(
        body: Center(
          child: buildUserList(),
        ),
      ),
    );
  }

  Widget buildUserList() {
    return ListView.builder(
      itemCount: _users != null ? _users.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return buildUserCard(index);
      },
    );
  }

  Widget buildUserCard(int index) {
    final User user = _users[index];

    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.picture)),
        title: Text('${user.firstName}'),
        subtitle: Text('${user.lastName}'),
      ),
    );
  }
}
