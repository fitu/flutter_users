import 'package:flutter/material.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_bloc.dart';
import 'package:flutter_random_user/bloc/favorite/favorite_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/ui/pages/favorite/favorites_page.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/items_list_widget.dart';
import 'package:flutter_random_user/ui/widgets/selection_widget/items_page_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

import '../../util/test_helper.dart';
import '../../util/users_factory.dart';

class MockFavoriteBloc extends Mock implements FavoriteBloc {}

void main() {
  final bloc = MockFavoriteBloc();
  Widget favoritesPage;

  setUp(() {
    favoritesPage = TestHelper.buildTestableWidget(FavoritesPage(bloc));
  });

  testWidgets('loadFavorites is called', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(FavoriteState.initial());

    // When
    await tester.pumpWidget(favoritesPage);

    // Then
    verify(bloc.loadFavorites()).called(1);
  });


  testWidgets('favorite is loading', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(FavoriteState.initial());

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(favoritesPage));

    // Then
    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('favorites list has no results', (WidgetTester tester) async {
    // Given
    List<User> users = [];
    when(bloc.initialState).thenReturn(FavoriteState.favorites(users));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(favoritesPage));

    // Then
    expect(find.text('Items not found'), findsOneWidget);
  });

  testWidgets('favorites list has correct results', (WidgetTester tester) async {
    // Given
    List<User> users = UserFactory.getUsers();
    when(bloc.initialState).thenReturn(FavoriteState.favorites(users));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(favoritesPage));

    // Then
    expect(find.text('samuele'), findsOneWidget);
  });

  testWidgets('favorites is shown as list', (WidgetTester tester) async {
    // Given
    List<User> users = UserFactory.getUsers();
    var isList = true;
    when(bloc.initialState).thenReturn(FavoriteState.swapList(users, isList));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(favoritesPage));

    // Then
    expect(find.byType(ItemsListWidget), findsOneWidget);
    expect(find.byType(ItemsPageWidget), findsNothing);
  });

  testWidgets('favorites is shown as page', (WidgetTester tester) async {
    // Given
    List<User> users = UserFactory.getUsers();
    var isList = false;
    when(bloc.initialState).thenReturn(FavoriteState.swapList(users, isList));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(favoritesPage));

    // Then
    expect(find.byType(ItemsPageWidget), findsOneWidget);
    expect(find.byType(ItemsListWidget), findsNothing);
  });
}
