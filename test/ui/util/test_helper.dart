import 'package:flutter/material.dart';

class TestHelper {
  static Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(home: widget),
    );
  }
}
