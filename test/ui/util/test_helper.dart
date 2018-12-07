import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestHelper {
  static Widget buildTestableWidget(Widget widget) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: DefaultAssetBundle(
          bundle: TestAssetBundle(),
          child: widget,
        ),
      ),
    );
  }
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    if (key == 'res/responses/user/user_response.json')
      return ByteData.view(Uint8List.fromList(utf8.encode('a')).buffer);
    return null;
  }
}
