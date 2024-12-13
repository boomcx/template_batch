import 'package:flutter/material.dart';
import 'package:tabs_template/service.dart';
import '/app.dart';

abstract class BaseView<T extends BaseViewController>
    extends GetView<BaseViewController> {
  const BaseView({super.key});

  @override
  T get controller => Get.find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    Widget view = buildBody(context);
    Widget body = GetBuilder(
      id: 'base_tap_refresh_network',
      init: controller,
      builder: (_) {
        return !AppService.to.isConnected.value
            ? notConnectivityView(context)
            : view;
      },
    );
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: buildBackgroundColor(context),
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: body,
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  bool get extendBody => false;
  bool get extendBodyBehindAppBar => false;
  bool? get resizeToAvoidBottomInset => null;

  /// 构建页面主体显示内容
  Widget buildBody(BuildContext context);

  /// 构建导航栏
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// 构建页面背景色
  Color? buildBackgroundColor(BuildContext context) => null;

  /// 构建页面底部显示内容
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// 没有网络连接的展示视图
  Widget notConnectivityView(BuildContext context) {
    return NetworkAnomalyView(
      onTap: () async {
        try {
          if (await AppService.to.connectedStatus) {
            controller.onBaseRequest();
            controller.update(['base_tap_refresh_network']);
          }
        } catch (e) {}
      },
    );
  }

  /// 是否需要动态显示网络连接状态页面
  ///
  /// 默认不开启
  bool get isDynamicCheckConnectivity => false;

  /// 通用导航栏
  commonAppBar({String? title, Color? backgroundColor}) {
    return AAppBar(
      title: title,
      backgroundColor: backgroundColor,
    );
  }
}

/// 通用导航栏
// class commonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const commonAppBar({this.title, this.backgroundColor, super.key});

//   final String? title;
//   final Color? backgroundColor;

//   @override
//   Widget build(BuildContext context) {
//     return AAppBar(
//       title: title,
//       backgroundColor: backgroundColor,
//       actions: const [
//         ServerIcon(),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize =>
//       const Size.fromHeight(kMinInteractiveDimensionCupertino + 2);
// }

abstract class BaseViewController extends GetxController {
  /// 进入页面时间
  int timestamp = 0;

  @override
  onInit() {
    timestamp = DateTime.now().millisecondsSinceEpoch;

    super.onInit();
    // if (!isPagedRefresh) {
    //   onRefresh();
    // }
  }

  /// 进入页面的初始数据获取
  Future onBaseRequest() async => null;
}
