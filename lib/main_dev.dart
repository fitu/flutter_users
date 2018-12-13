import 'package:flutter/material.dart';
import 'package:flutter_random_user/app_config.dart';
import 'package:flutter_random_user/ui/app.dart';

void main() {
  var configuredApp = AppConfig(
    baseUrl: 'http://127.0.0.1:8081/',
    child: UsersApp(),
  );

  runApp(configuredApp);
}
