import 'package:flutter_random_user/data/repository/net/api_service.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final ApiService _apiService = ApiService();
  final ReplaySubject<dynamic> _subject = ReplaySubject<dynamic>();
  Stream<List<User>> _results = Stream.empty();

  UserBloc() {
    _results = _subject.switchMap<List<User>>((_) => _apiService.getUsers());
  }

  Stream<List<User>> get results => _results;

  Sink<dynamic> get sink => _subject;

  void dispose() {
    _subject.close();
  }
}

