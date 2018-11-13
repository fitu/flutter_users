import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/bloc_provider.dart';
import 'package:flutter_random_user/data/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/data/bloc/user/user_event.dart';
import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_center_loading.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_icon_button.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_item_widget.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_scaffold.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.inEvents.add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        title: 'Random Users',
        child: buildBody(),
        rightIconButton: PlatformIconButton(
          iconData: Icons.favorite,
          onPressed: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ));
  }

  Widget buildBody() {
    return StreamBuilder<UserState>(
      stream: userBloc.outState,
      initialData: LoadingUsers(),
      builder: (BuildContext context, AsyncSnapshot<UserState> snapshot) {
        final UserState state = snapshot.data;
        return Container(
          child: render(state),
        );
      },
    );
  }

  Widget render(UserState state) {
    if (state is LoadingUsers) {
      return renderLoading();
    }
    if (state is NotUsersFound) {
      return renderNotFoundUsers();
    }
    if (state is UsersError) {
      return renderErrorUsers(state);
    }
    if (state is SuccessLoadingUsers) {
      return renderUserList(state.users);
    }
    throw UnimplementedError();
  }

  Widget renderLoading() {
    return PlatformCenterLoading();
  }

  Widget renderNotFoundUsers() {
    return Center(child: Text('Not users found!'));
  }

  Widget renderErrorUsers(UsersError state) {
    return Center(child: Text(state.error.toString()));
  }

  Widget renderUserList(List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return buildUserCard(users[index]);
      },
    );
  }

  Widget buildUserCard(User user) {
    return PlatformItemWidget(
        child: ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.picture)),
      title: Text('${user.firstName}'),
      subtitle: Text('${user.lastName}'),
      trailing: FavoriteButton(user),
    ));
  }
}

class FavoriteButton extends StatefulWidget {
  final User user;

  FavoriteButton(this.user);

  @override
  State<StatefulWidget> createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  User newUser;
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    this.newUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.favorite, color: newUser.isFavorite ? Colors.red : Colors.blueGrey),
        onPressed: () => changeFavorite(newUser));
  }

  void changeFavorite(User user) async {
    final result = await userBloc.asFavorite(user);
    setState(() {
      this.newUser = result;
    });
  }
}
