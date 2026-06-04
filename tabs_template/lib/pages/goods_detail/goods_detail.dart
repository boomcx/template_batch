import 'package:get/get.dart';
import 'package:tabs_template/pages/goods_detail/src/controller.dart';

export 'package:tabs_template/pages/goods_detail/src/controller.dart';
export 'package:tabs_template/pages/goods_detail/src/view.dart';

/// 独立到每个页面，用脚本生成对应的路由名称
/// 路由名称
///
const String kRouteGoodsDetail = '/goods_detail';

/// AppPages : 注册 GetPage
/// 可以直接复制到 AppPages 文件中注册页面路由
///
/// ```
///    GetPage(
///       name: kRouteGoodsDetail,
///       page: () => const GoodsDetailView(),
///       binding: GoodsDetailBinding(),
///     ),
/// ```
///
class GoodsDetailBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.create<GoodsDetailController>(
        (_) => GoodsDetailController(),
      )
    ];
  }
}
