import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_event.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/ui/pages/user/favorite_button.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_center_loading.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_icon_button.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_item_widget.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_scaffold.dart';

class UsersPage extends StatelessWidget {
  final UserBloc _bloc;

  UsersPage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: 'Random Users',
      child: UserBody(bloc: _bloc),
      rightIconButton: PlatformIconButton(
        key: Key('navigateToFavorites'),
        iconData: Icons.favorite,
        onPressed: () {
          Navigator.pushNamed(context, '/favorites');
        },
      ),
    );
  }
}

class UserBody extends StatefulWidget {
  final UserBloc bloc;

  UserBody({@required this.bloc});

  @override
  _UsersBodyState createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UserBody> {
  bool _notFound(UserState state) => state.isLoading == false && state.users == null;

  bool _error(UserState state) => state.errorMessage != null;

  bool _success(UserState state) => state.users != null;

  @override
  void initState() {
    super.initState();
    widget.bloc.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserEvent, UserState>(
      bloc: widget.bloc,
      builder: (BuildContext context, UserState state) {
        Widget toRender = _renderLoading();
        if (_notFound(state)) {
          toRender = _renderNotFound();
        }
        if (_error(state)) {
          toRender = _renderError(state);
        }
        if (_success(state)) {
          toRender = _renderSuccess(state);
        }
        return toRender;
      },
    );
  }

  Widget _renderLoading() {
    return PlatformCenterLoading();
  }

  Widget _renderNotFound() {
    return Center(child: Text('Not users found!'));
  }

  Widget _renderError(UserState state) {
    return Center(child: Text(state.errorMessage));
  }

  Widget _renderSuccess(UserState state) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (BuildContext context, int index) {
        return buildUserCard(state.users[index]);
      },
    );
  }

  Widget buildUserCard(User user) {
    return PlatformItemWidget(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(user.picture)),
        title: Text('${user.firstName}'),
        subtitle: Text('${user.lastName}'),
        trailing: FavoriteButton(user, widget.bloc),
      ),
    );
  }
}
