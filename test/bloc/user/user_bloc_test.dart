import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_event.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RepositoryMock extends Mock implements Repository {}

class UserMock extends Mock implements User {}

void main() {
  UserBloc bloc;
  Repository repositoryMock = RepositoryMock();

  setUp(() {
    bloc = UserBloc(repositoryMock);
  });

  test('initial state is correct', () {
    // Then
    expect(bloc.initialState, UserState.initial());
  });

  test('dispose does not emit new state', () {
    // When
    bloc.dispose();

    // Then
    expectLater(bloc.state, emitsInOrder([UserState.initial()]));
  });

  group('LoadUsers()', () {
    test('emits [initial, loading, success] for LoadUsers', () {
      // Given
      final List<User> expectedUsers = [];
      when(repositoryMock.getUsers()).thenAnswer((_) => Future.value(expectedUsers));

      final expectedResponse = [
        UserState.initial(),
        UserState.loading(),
        UserState.success(expectedUsers),
      ];

      // When
      bloc.dispatch(LoadUsers());

      // Then
      expectLater(
        bloc.state,
        emitsInOrder(expectedResponse),
      );
    });

    test('emits [initial, loading, error] for LoadUsers', () {
      // Given
      final Error expectedError = Error();
      when(repositoryMock.getUsers()).thenThrow(expectedError);

      final expectedResponse = [
        UserState.initial(),
        UserState.loading(),
        UserState.error(expectedError),
      ];

      // When
      bloc.dispatch(LoadUsers());

      // Then
      expectLater(
        bloc.state,
        emitsInOrder(expectedResponse),
      );
    });
  });

  group('FavoritePressed()', () {
    test('calls removeFromFavorite', () {
      // Given
      User userMock = UserMock();
      when(userMock.isFavorite).thenReturn(true);

      // When
      bloc.onFavoritePressed(FavoritePressed(userMock));

      // Then
      verify(repositoryMock.removeFromFavorite(userMock)).called(1);
      verifyNever(repositoryMock.saveAsFavorite(userMock));
    });

    test('calls saveAsFavorite', () {
      // Given
      User userMock = UserMock();
      when(userMock.isFavorite).thenReturn(false);

      // When
      bloc.onFavoritePressed(FavoritePressed(userMock));

      // Then
      verifyNever(repositoryMock.removeFromFavorite(userMock));
      verify(repositoryMock.saveAsFavorite(userMock)).called(1);
    });
  });
}
