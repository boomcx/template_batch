library test;

import 'package:get/get.dart';
import './src/controller.dart';

export './src/controller.dart';
export './src/view.dart';

/// 独立到每个页面，用脚本生成对应的路由名称
/// 路由名称
///
const String kRouteTest = '/test';

/// AppPages : 注册 GetPage
/// 可以直接复制到 AppPages 文件中注册页面路由
///
/// ```
///    GetPage(
///       name: kRouteTest,
///       page: () => const TestView(),
///       binding: TestBinding(),
///     ),
/// ```
/// 
class TestBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<TestController>(
        () => TestController(),
      )
    ];
  }
}

