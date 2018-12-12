import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_event.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../ui/util/users_factory.dart';

class RepositoryMock extends Mock implements Repository {}

void main() {
  final repositoryMock = RepositoryMock();
  UserBloc bloc;

  setUp(() {
    bloc = UserBloc(repository: repositoryMock);
  });

  test('loading state is correct', () {
    // Then
    expect(bloc.initialState, UserState.loading());
  });

  test('dispose does not emit new state', () {
    // When
    bloc.dispose();

    // Then
    expectLater(bloc.state, emitsInOrder([UserState.loading()]));
  });

  group('LoadUsers()', () {
    test('emits [loading, success] for LoadUsers', () {
      // Given
      List<User> expectedUsers = [];
      when(repositoryMock.getUsers()).thenAnswer((_) => Future.value(expectedUsers));

      var expectedResponse = [
        UserState.loading(),
        UserState.success(expectedUsers),
      ];

      // When
      bloc.dispatch(LoadUsers());

      // Then
      expectLater(bloc.state, emitsInOrder(expectedResponse));
    });

    test('emits [loading, error] for LoadUsers', () {
      // Given
      when(repositoryMock.getUsers()).thenThrow('foo');

      var expectedResponse = [
        UserState.loading(),
        UserState.error('foo'),
      ];

      // When
      bloc.dispatch(LoadUsers());

      // Then
      expectLater(bloc.state, emitsInOrder(expectedResponse));
    });
  });

  group('FavoritePressed()', () {
    test('calls removeFromFavorite', () {
      // Given
      final user = UserFactory.getFavoriteUser();

      // When
      bloc.onFavoritePressed(FavoritePressed(user));

      // Then
      verify(repositoryMock.removeFromFavorite(user)).called(1);
      verifyNever(repositoryMock.saveAsFavorite(user));
    });

    test('calls saveAsFavorite', () {
      // Given
      final user = UserFactory.getNotFavoriteUser();

      // When
      bloc.onFavoritePressed(FavoritePressed(user));

      // Then
      verifyNever(repositoryMock.removeFromFavorite(user));
      verify(repositoryMock.saveAsFavorite(user)).called(1);
    });
  });
}
