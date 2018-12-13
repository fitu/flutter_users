import 'package:flutter/material.dart';
import 'package:flutter_random_user/app_config.dart';
import 'package:flutter_random_user/ui/app.dart';

void main() {
  var configuredApp = AppConfig(
    baseUrl: 'https://randomuser.me/api/',
    child: UsersApp(),
  );

  runApp(configuredApp);
}
