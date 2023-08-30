import '/pages/godos_detail/godos_detail.dart';
import '/pages/mine/mine.dart';
import '/pages/home/home.dart';

import 'package:get/get.dart';

import '/tabbar.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = kRouteHome;

  static final routes = [
    GetPage(
      name: kRouteHome,
      // participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const TabbarScaffold(
        type: TabbarType.home,
        body: HomeView(),
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: kRouteMine,
      // participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const TabbarScaffold(
        type: TabbarType.mine,
        body: MineView(),
      ),
      binding: MineBinding(),
    ),
    GetPage(
      name: kRouteGodosDetail,
      page: () => GodosDetailView(id: '${Get.parameters['id']}'),
      binding: GodosDetailBinding(),
    ),
  ];
}
