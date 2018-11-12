import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  static const String URL = 'https://randomuser.me/api/';

  @override
  void initState() {
    doRequest();
    super.initState();
  }

  Future<void> doRequest() async {
    final response = await http.get(URL);
    setState(() {
      var body = json.decode(response.body);
      print(body['results']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random User',
      home: Scaffold(
        body: Center(),
      ),
    );
  }
}
