import '/pages/godos_detail/godos_detail.dart';

import 'package:get/get.dart';

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
  ];
}
