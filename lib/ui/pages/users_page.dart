import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/repository/net/api_service.dart';
import 'package:flutter_random_user/model/user.dart';

class UsersPage extends StatefulWidget {
  final ApiService apiService = ApiService();

  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> _users;

  @override
  void initState() {
    doRequest();
    super.initState();
  }

  Future<void> doRequest() async {
    List<User> newUsers = await widget.apiService.getUsers();
    setState(() {
      _users = newUsers;
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
