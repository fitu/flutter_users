import 'dart:convert';
import 'dart:io';

import 'package:flutter_random_user/model/user.dart';
import 'package:flutter_random_user/repository/parser/user_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parse is correct', () async {
    // Given
    var file = File('res/responses/user/user_response.json');
    var jsonMap = json.decode(await file.readAsString());

    // When
    List<User> users = UserParser.fromBE(jsonMap);

    // Then
    expect(users.length, 10);
    expect(users[0].firstName, 'samuele');
    expect(users[0].lastName, 'rousseau');
    expect(users[0].isFavorite, false);
    expect(users[0].picture, 'https://randomuser.me/api/portraits/med/men/14.jpg');
  });
}
