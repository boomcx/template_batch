import 'package:get/get.dart';

import '../../tabbar.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/mine/bindings/mine_binding.dart';
import '../modules/mine/views/mine_view.dart';
import '../modules/news_detail/bindings/news_detail_binding.dart';
import '../modules/news_detail/views/news_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      // participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const TabbarScaffold(
        type: TabbarType.home,
        body: HomeView(),
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MINE,
      // participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const TabbarScaffold(
        type: TabbarType.mine,
        body: MineView(),
      ),
      binding: MineBinding(),
    ),
    GetPage(
      name: _Paths.NEWS_DETAIL,
      page: () => NewsDetailView(id: '${Get.parameters['id']}'),
      binding: NewsDetailBinding(),
    ),
  ];
}
