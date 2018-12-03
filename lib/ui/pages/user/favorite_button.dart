import 'package:flutter/material.dart';
import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_event.dart';
import 'package:flutter_random_user/model/user.dart';

class FavoriteButton extends StatefulWidget {
  final User user;
  final UserBloc userBloc;

  FavoriteButton(this.user, this.userBloc);

  @override
  State<StatefulWidget> createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton> {
  User newUser;

  @override
  void initState() {
    super.initState();
    this.newUser = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.favorite, color: newUser.isFavorite ? Colors.red : Colors.blueGrey),
        onPressed: () => changeFavorite(newUser));
  }

  void changeFavorite(User user) async {
    var result = await widget.userBloc.onFavoritePressed(FavoritePressed(user));
    setState(() {
      this.newUser = result;
    });
  }
}