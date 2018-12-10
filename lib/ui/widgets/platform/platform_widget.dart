import 'dart:io' show Platform;

import 'package:flutter/material.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget> extends StatelessWidget {
  final Key key;

  PlatformWidget(this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return buildIOSWidget(context);
    }
    return buildAndroidWidget(context);
  }

  I buildIOSWidget(BuildContext context);

  A buildAndroidWidget(BuildContext context);
}
