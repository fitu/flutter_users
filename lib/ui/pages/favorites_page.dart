import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/bloc_provider.dart';
import 'package:flutter_random_user/data/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/data/bloc/user/user_event.dart';
import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/Item.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_icon_button.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/selection_widget.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/item_selection_state.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.inEvents.add(LoadFavoriteUsers());
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: 'Favorites',
      child: buildBody(),
      rightIconButton: PlatformIconButton(
        iconData: Icons.dashboard,
        onPressed: () => userBloc.inEvents.add(SwapRenderMode()),
      ),
    );
  }

  Widget buildBody() {
    return StreamBuilder<UserState>(
      stream: userBloc.outState,
      initialData: LoadingUsers(),
      builder: (BuildContext context, AsyncSnapshot<UserState> snapshot) {
        return render(snapshot.data);
      },
    );
  }

  Widget render(UserState state) {
    if (state is LoadingUsers) {
      return SelectionWidget(statusItemSelection: LoadingMode());
    }
    if (state is NotUsersFound) {
      return SelectionWidget(statusItemSelection: EmptyMode());
    }
    if (state is FavoriteUsers) {
      final List<Item> items = state.users.map((user) => Item.fromUser(user)).toList();
      return SelectionWidget(statusItemSelection: ListMode(items));
    }
    if (state is SwapListType) {
      final List<Item> items = state.users.map((user) => Item.fromUser(user)).toList();
      return SelectionWidget(statusItemSelection: SwapListMode(items, state.isList));
    }
    throw UnimplementedError();
  }
}
