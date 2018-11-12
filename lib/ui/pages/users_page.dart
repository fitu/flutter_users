import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/bloc_provider.dart';
import 'package:flutter_random_user/data/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/model/user.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.userBloc(context);
    userBloc.getUsers();

    return StreamBuilder<List<User>>(
      stream: userBloc.results,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        return Scaffold(
          body: Center(
            child: buildUserList(snapshot.data),
          ),
        );
      },
    );
  }

  Widget buildUserList(List<User> users) {
    return ListView.builder(
      itemCount: users != null ? users.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return buildUserCard(users[index]);
      },
    );
  }

  Widget buildUserCard(User user) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.picture)),
        title: Text('${user.firstName}'),
        subtitle: Text('${user.lastName}'),
      ),
    );
  }
}
