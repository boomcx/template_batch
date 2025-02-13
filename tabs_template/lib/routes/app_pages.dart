import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '/pages/goods_detail/goods_detail.dart';

import '../widgets/common/toast.dart';
import '/pages/mine/theme_change/theme_change.dart';
import '/tabbar.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const initial = kRouteTabbar;

  static final routes = [
    GetPage(
      name: kRouteTabbar,
      participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const TabbarScaffold(),
      binding: TabbarBinding(),
      canPop: false,
      onPopInvoked: (didPop, result) {
        AppHandler.instance.exit();
      },
      // children: [
      //   GetPage(
      //     name: kRouteTabbarHome,
      //     page: () => const TabbarScaffold(TabbarType.home),
      //   ),
      //   GetPage(
      //     name: kRouteTabbarMessage,
      //     page: () => const TabbarScaffold(TabbarType.message),
      //   ),
      //   GetPage(
      //     name: kRouteTabbarMine,
      //     page: () => const TabbarScaffold(TabbarType.mine),
      //   ),
      // ],
    ),
    GetPage(
      name: kRouteGoodsDetail,
      page: () => const GoodsDetailView(),
      binding: GoodsDetailBinding(),
    ),
    GetPage(
      name: kRouteThemeChange,
      page: () => const ThemeChangeView(),
      binding: ThemeChangeBinding(),
      preventDuplicates: false,
      preventDuplicateHandlingMode: PreventDuplicateHandlingMode.recreate,
    ),
  ];

  /// GetRouterOutlet mode 嵌套式导航
  // static final routes = [ ];
}

/// 双击退出应用
class AppHandler {
  AppHandler._();
  static final instance = AppHandler._();

  Timer? timer;
  bool isQuit = false;

  /// 退出应用程序
  exit() async {
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
