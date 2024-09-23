import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../widgets/common/toast.dart';
import '/pages/godos_detail/godos_detail.dart';
import '/pages/mine/theme_change/theme_change.dart';
import '/tabbar.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = kRouteTabbar;

  static final routes = [
    GetPage(
      name: kRouteTabbar,
      participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const TabbarScaffold(),
      binding: TabbarBinding(),
      canPop: false,
      onPopInvoked: (didPop, result) {
        AppHandler.instance.esc();
      },
    ),
    GetPage(
      name: kRouteGodosDetail,
      page: () => const GodosDetailView(),
      binding: GodosDetailBinding(),
    ),
    GetPage(
      name: kRouteThemeChange,
      page: () => const ThemeChangeView(),
      binding: ThemeChangeBinding(),
      preventDuplicates: false,
      preventDuplicateHandlingMode: PreventDuplicateHandlingMode.recreate,
    ),
  ];
}

/// 双击退出应用
class AppHandler {
  AppHandler._();
  static final instance = AppHandler._();

  Timer? timer;
  bool isQuit = false;

  /// 退出应用程序
  esc() async {
    if (isQuit) {
      // exit(0);
      await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      showMessage('再次操作退出App');
      isQuit = true;
      timer = Timer(const Duration(seconds: 2), () {
        isQuit = false;
        timer?.cancel();
        timer = null;
      });
    }
  }
}
