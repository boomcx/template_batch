import 'package:get/get.dart';

import '/pages/home/home.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = kRouteHome;

  static final routes = [
    GetPage(
      name: kRouteHome,
      participatesInRootNavigator: true,
      transition: Transition.noTransition,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
