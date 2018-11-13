import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/bloc_provider.dart';
import 'package:flutter_random_user/data/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.userBloc(context);
    userBloc.sink.add('');

    return StreamBuilder<UserState>(
      stream: userBloc.results,
      initialData: LoadingUsers(),
      builder: (BuildContext context, AsyncSnapshot<UserState> snapshot) {
        final UserState state = snapshot.data;
        return Scaffold(
          body: Container(
            child: render(state),
          ),
        );
      },
    );
  }

  Widget render(UserState state) {
    if (state is LoadingUsers) {
      return renderLoading();
    }
    if (state is NotFoundUsers) {
      return renderNotFoundUsers();
    }
    if (state is ErrorUsers) {
      return renderErrorUsers(state);
    }
    if (state is SuccessUsers) {
      return renderSuccessUsers(state);
    }
    throw UnimplementedError();
  }

  Widget renderLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget renderNotFoundUsers() {
    return Center(child: Text('Not users found!'));
  }

  Widget renderErrorUsers(ErrorUsers state) {
    return Center(child: Text(state.error.toString()));
  }

  Widget renderSuccessUsers(SuccessUsers state) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (BuildContext context, int index) {
        return buildUserCard(state.users[index]);
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
