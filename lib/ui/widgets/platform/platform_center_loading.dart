import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_random_user/ui/widgets/platform/platform_widget.dart';


class PlatformCenterLoading extends PlatformWidget<Center, Center> {
  @override
  Center buildAndroidWidget(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Center buildIOSWidget(BuildContext context) {
    return Center(child: CupertinoActivityIndicator());
  }
}