import 'package:flutter_random_user/repository/db/dao.dart';
import 'package:flutter_random_user/repository/db/tables/user_table.dart';
import 'package:flutter_random_user/repository/net/api_service.dart';
import 'package:flutter_random_user/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../ui/util/users_factory.dart';

class MockApiService extends Mock implements ApiService {}

class MockDAO extends Mock implements DAO {}

class MockTableFavoriteUser extends Mock implements TableFavoriteUser {}

void main() {
  final apiService = MockApiService();
  final dao = MockDAO();
  final tableFavoriteUser = MockTableFavoriteUser();
  Repository repository;

  setUp(() {
    repository = Repository(apiService: apiService, dao: dao);
  });

  test('getUsers calls apiService', () {
    // When
    repository.getUsers();

    // Then
    verify(apiService.getUsers()).called(1);
  });

  test('saveAsFavorite change user.isFavorite and save it to DB', () async {
    // Given
    var user = UserFactory.getFavoriteUser();
    when(dao.tableUser).thenAnswer((_) => Future.value(tableFavoriteUser));

    // When
    var userResult = await repository.saveAsFavorite(user);

    // Then
    verify(tableFavoriteUser.addUser(userResult)).called(1);
    expect(userResult.isFavorite, true);
  });

  test('removeFromFavorite change user.isFavorite and remove it to DB', () async {
    // Given
    var user = UserFactory.getFavoriteUser();
    when(dao.tableUser).thenAnswer((_) => Future.value(tableFavoriteUser));

    // When
    var userResult = await repository.removeFromFavorite(user);

    // Then
    verify(tableFavoriteUser.deleteUser(userResult.id)).called(1);
    expect(userResult.isFavorite, false);
  });

  test('loadFavorites calls dao', () async {
    // Given
    when(dao.tableUser).thenAnswer((_) => Future.value(tableFavoriteUser));

    // When
    await repository.loadFavorites();

    // Then
    verify(tableFavoriteUser.getAllUsers()).called(1);
  });
}
