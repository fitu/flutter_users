import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_widget.dart';

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final String title;
  final Widget child;
  final Widget rightIconButton;

  PlatformScaffold(
      {@required this.title,
      @required this.child,
      @required this.rightIconButton});

  @override
  Scaffold buildAndroidWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[rightIconButton],
      ),
      body: child,
    );
  }

  @override
  CupertinoPageScaffold buildIOSWidget(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
          trailing: rightIconButton,
        ),
        child: child);
  }
}
