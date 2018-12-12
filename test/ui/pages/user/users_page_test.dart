import 'package:flutter/material.dart';
import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/ui/pages/user/users_page.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_center_loading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:mockito/mockito.dart';

import '../../util/test_helper.dart';
import '../../util/users_factory.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  final bloc = MockUserBloc();
  List<User> users;
  Widget usersPage;

  setUp(() {
    users = UserFactory.getUsers();
    usersPage = TestHelper.buildTestableWidget(UsersPage(bloc));
  });

  testWidgets('loadUsers is called', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(UserState.loading());

    // When
    await tester.pumpWidget(usersPage);

    // Then
    verify(bloc.loadUsers()).called(1);
  });

  testWidgets('onSuccess list has correct results', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(UserState.success(users));
    Finder heartButtonFinder = find.byKey(Key('1'));
    Finder iconFinder = find.descendant(of: heartButtonFinder, matching: find.byIcon(Icons.favorite));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(usersPage));

    // Then
    expect(find.text('samuele'), findsOneWidget);
    expect(find.text('rousseau'), findsOneWidget);

    Icon icon = tester.widget(iconFinder);
    expect(icon.color, Colors.blueGrey);
  });

  testWidgets('onSuccess list shows heart in red', (WidgetTester tester) async {
    // Given
    users.removeAt(0);
    users.insert(0, UserFactory.getFavoriteUser());
    when(bloc.initialState).thenReturn(UserState.success(users));

    Finder heartButtonFinder = find.byKey(Key('1'));
    Finder iconFinder = find.descendant(of: heartButtonFinder, matching: find.byIcon(Icons.favorite));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(usersPage));

    // Then
    Icon icon = tester.widget(iconFinder);
    expect(icon.color, Colors.red);
  });

  testWidgets('onNotFound shows text', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(UserState.notFound());

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(usersPage));

    // Then
    expect(find.text('Not users found!'), findsOneWidget);
  });

  testWidgets('onLoading shows loading', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(UserState.loading());

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(usersPage));

    // Then
    expect(find.byType(PlatformCenterLoading), findsOneWidget);
  });

  testWidgets('onError shows text', (WidgetTester tester) async {
    // Given
    when(bloc.initialState).thenReturn(UserState.error('There was an error'));

    // When
    await provideMockedNetworkImages(() async => await tester.pumpWidget(usersPage));

    // Then
    expect(find.text('There was an error'), findsOneWidget);
  });
}
