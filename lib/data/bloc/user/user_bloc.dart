import 'package:flutter_random_user/data/bloc/user/user_state.dart';
import 'package:flutter_random_user/data/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final Repository _repository = Repository();
  final ReplaySubject<dynamic> _subject = ReplaySubject<dynamic>();
  Stream<UserState> _results = Stream.empty();

  UserBloc() {
    _results = _subject.switchMap<UserState>((_) => _repository.getUsers());
  }

  Stream<UserState> get results => _results;

  Sink<dynamic> get sink => _subject;

  void dispose() {
    _subject.close();
  }
}
