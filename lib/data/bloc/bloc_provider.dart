import 'package:flutter/material.dart';
import 'package:flutter_random_user/data/bloc/user/user_bloc.dart';

class BlocProvider extends InheritedWidget {
  final UserBloc _userBloc;

  BlocProvider({Key key, Widget child})
      : this._userBloc = UserBloc(),
        super(key: key, child: child);

  static UserBloc userBloc(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)._userBloc;

  @override
  bool updateShouldNotify(_) => true;
}
