import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_widget.dart';


class PlatformItemWidget extends PlatformWidget<Widget, Card> {

  final Widget child;

  PlatformItemWidget({this.child});

  @override
  Card buildAndroidWidget(BuildContext context) {
    return Card(child: child);
  }

  @override
  Widget buildIOSWidget(BuildContext context) {
    return Card(child: child, elevation: 0.2, margin: EdgeInsets.all(1.0));
  }
}