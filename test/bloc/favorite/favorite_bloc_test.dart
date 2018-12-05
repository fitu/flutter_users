import 'package:flutter_random_user/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_event.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements Repository {}

void main() {
  FavoriteBloc bloc;
  Repository repositoryMock = MockRepository();

  setUp(() {
    bloc = FavoriteBloc(repositoryMock);
  });

  test('initial state is correct', () {
    // Then
    expect(bloc.initialState, FavoriteState.initial());
  });

  test('dispose does not emit new state', () {
    // When
    bloc.dispose();

    // Then
    expectLater(bloc.state, emitsInOrder([FavoriteState.initial()]));
  });

  group('LoadFavorites()', () {
    test('emits [initial, favorites] for LoadFavorites', () {
      // Given
      final List<User> expectedUsers = [];
      final expectedResponse = [
        FavoriteState.initial(),
        FavoriteState.favorites(expectedUsers),
      ];
      when(repositoryMock.loadFavorites()).thenAnswer((_) => Future.value(expectedUsers));

      // When
      bloc.dispatch(LoadFavorites());

      // Then
      expectLater(
        bloc.state,
        emitsInOrder(expectedResponse),
      );
    });
  });

  group('SwapRenderMode()', () {
    test('emits [initial, swapList] for SwapRenderMode', () {
      expect(bloc.isList, true);

      // Given
      final List<User> expectedUsers = [];
      when(repositoryMock.loadFavorites()).thenAnswer((_) => Future.value(expectedUsers));

      final expectedResponse = [
        FavoriteState.initial(),
        FavoriteState.swapList(expectedUsers, false),
      ];

      // When
      bloc.dispatch(SwapRenderMode());

      // Then
      expectLater(
        bloc.state,
        emitsInOrder(expectedResponse),
      );
    });
  });
}
