import 'package:flutter/material.dart';

class CustomScrollBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // 禁用安卓风格滑动辉光效果
    return child;
  }
}
