import 'package:get/get.dart';

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
    ),
    GetPage(
      name: kRouteGodosDetail,
      page: () => GodosDetailView(id: '${Get.parameters['id']}'),
      binding: GodosDetailBinding(),
    ),
    GetPage(
      name: kRouteThemeChange,
      page: () => const ThemeChangeView(),
      binding: ThemeChangeBinding(),
    ),
  ];
}
