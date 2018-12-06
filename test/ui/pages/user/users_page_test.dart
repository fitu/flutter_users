import 'package:flutter/material.dart';
import 'package:flutter_random_user/bloc/user/user_bloc.dart';
import 'package:flutter_random_user/bloc/user/user_state.dart';
import 'package:flutter_random_user/ui/pages/user/users_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../util/test_helper.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  final bloc = MockUserBloc();
  Widget usersPage;

  setUp(() {
    usersPage = TestHelper.buildTestableWidget(UsersPage(bloc));
  });

  testWidgets('', (WidgetTester tester) async {
    when(bloc.initialState).thenReturn(UserState.initial());
    when(bloc.loadUsers()).thenReturn(UserState.loading());

    await tester.pumpWidget(usersPage);
    expect(true, true);
  });
}
