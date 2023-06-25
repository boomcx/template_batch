import 'package:flutter/cupertino.dart';

extension BuildContextExtension on BuildContext {
  void dismissKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

   Future<T?> pushPage<T>(Widget widget, {bool fullscreenDialog = false}) {
    return Navigator.push<T>(
      this,
      CupertinoPageRoute<T>(
        builder: (context) => widget,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }
}
