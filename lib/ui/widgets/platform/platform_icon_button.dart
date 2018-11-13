import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_widget.dart';

class PlatformIconButton extends PlatformWidget<CupertinoButton, IconButton> {
  final IconData iconData;
  final VoidCallback onPressed;

  PlatformIconButton({this.iconData, this.onPressed});

  @override
  IconButton buildAndroidWidget(BuildContext context) {
    return IconButton(icon: Icon(iconData), onPressed: onPressed);
  }

  @override
  CupertinoButton buildIOSWidget(BuildContext context) {
    return CupertinoButton(child: Icon(iconData, size: 24.0), onPressed: onPressed);
  }
}
