import 'dart:io';

import 'package:flutter_random_user/repository/net/api.dart';
import 'package:flutter_random_user/repository/net/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';

void main() {
  var apiService;
  var server;

  setUpAll(() async {
    Api.BASE_URL = 'http://127.0.0.1:8081/';
  });

  setUp(() async {
    apiService = ApiService();
    server = MockWebServer(port: 8081);
    await server.start();
  });

  tearDown(() {
    if (server != null) {
      server.shutdown();
    }
  });

  test('getUsers returns a list of users', () async {
    // Given
    var file = File('res/responses/user/user_response.json');
    server.enqueue(body: await file.readAsString());

    // When
    var result = await apiService.getUsers();

    // Then
    expect(result.length, 10);
  });

  test('getUsers throws an error', () async {
    // Given
    server.enqueue(httpCode: 401);

    try {
      // When
      await apiService.getUsers();
    } catch (exception) {
      // Then
      expect(exception, 'There was an error');
    }
  });
}
