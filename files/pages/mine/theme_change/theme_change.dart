library theme_change;

import 'package:get/get.dart';

import './controller.dart';

export './controller.dart';
export './view.dart';

/// 独立到每个页面，用脚本生成对应的路由名称
/// 路由名称
///
const String kRouteThemeChange = '/theme_change';

/// AppPages : 注册 GetPage
/// 可以直接复制到 AppPages 文件中注册页面路由
///
/// ```
///    GetPage(
///       name: kRouteThemeChange,
///       page: () => ThemeChangeView(),
///       binding: ThemeChangeBinding(),
///     ),
/// ```
///
class ThemeChangeBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ThemeChangeController>(
        () => ThemeChangeController(),
      )
    ];
  }
}
