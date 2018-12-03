import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_event.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_state.dart';
import 'package:flutter_random_user/model/Item.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_icon_button.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_scaffold.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/item_selection_state.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/selection_widget.dart';

class FavoritesPage extends StatelessWidget {
  final _bloc = FavoriteBloc();

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      title: 'Favorites',
      child: FavoriteBody(bloc: _bloc),
      rightIconButton: PlatformIconButton(
        iconData: Icons.dashboard,
        onPressed: _bloc.swapRenderMode,
      ),
    );
  }
}

class FavoriteBody extends StatefulWidget {
  final FavoriteBloc bloc;

  FavoriteBody({@required this.bloc});

  @override
  _FavoriteBodyState createState() => _FavoriteBodyState();
}

class _FavoriteBodyState extends State<FavoriteBody> {
  bool _favorites(FavoriteState state) => state.users != null;

  bool _swapList(FavoriteState state) => state.isList != null;

  @override
  void initState() {
    super.initState();
    widget.bloc.loadFavorites();
  }

  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteEvent, FavoriteState>(
      bloc: widget.bloc,
      builder: (BuildContext context, FavoriteState state) {
        Widget toRender = _renderInitial();
        if (_favorites(state)) {
          toRender = _renderFavorites(state);
        }
        if (_swapList(state)) {
          toRender = _renderSwapList(state);
        }
        return toRender;
      },
    );
  }

  Widget _renderInitial() {
    return SelectionWidget(statusItemSelection: LoadingMode());
  }

  Widget _renderFavorites(FavoriteState state) {
    if (state.users.isEmpty) {
      return SelectionWidget(statusItemSelection: EmptyMode());
    }

    final List<Item> items = state.users.map((user) => Item.fromUser(user)).toList();
    return SelectionWidget(statusItemSelection: ListMode(items));
  }

  Widget _renderSwapList(FavoriteState state) {
    final List<Item> items = state.users.map((user) => Item.fromUser(user)).toList();
    return SelectionWidget(statusItemSelection: SwapListMode(items, state.isList));
  }
}
