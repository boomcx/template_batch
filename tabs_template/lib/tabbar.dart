import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'app.dart';

import './pages/message/message.dart';
import '/pages/home/home.dart';
import '/pages/mine/mine.dart';

enum TabbarType {
  home,
  message,
  mine;

  String get title {
    switch (this) {
      case TabbarType.home:
        return '首页';
      case TabbarType.message:
        return '消息';
      case TabbarType.mine:
        return '我的';
    }
  }

  String get icon {
    return 'ic_home';
  }

  Widget get body {
    switch (this) {
      case TabbarType.home:
        return const HomeView();
      case TabbarType.message:
        return const MessageView();
      case TabbarType.mine:
        return const MineView();
    }
  }
}

class TabbarController extends GetxController {
  static TabbarController get to => Get.find();

  var tabCur = TabbarType.home.obs;

  /// 指定切换到根路径
  void switchTo([TabbarType tab = TabbarType.home]) {
    Get.offAllNamed(kRouteTabbar);
    tabCur.value = tab;
  }
}

class TabbarScaffold extends GetView<TabbarController> {
  const TabbarScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: controller.tabCur.value.body,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: TabbarType.values.length,
          tabBuilder: (index, isActive) {
            final item = TabbarType.values[index];
            return Center(
                child: _assets(item.icon + (isActive ? '_slt' : '_nor')));
          },
          backgroundColor: Colors.white,
          gapLocation: GapLocation.none,
          activeIndex: controller.tabCur.value.index,
          onTap: (index) {
            controller.tabCur.value = TabbarType.values[index];
          },
        ),
      ),
    );

    // return PersistentTabView(
    //   controller: controller.persistent,
    //   screenTransitionAnimation: const ScreenTransitionAnimation.none(),
    //   tabs: TabbarType.values
    //       .map(
    //         (e) => PersistentTabConfig(
    //           screen: e.body,
    //           item: ItemConfig(
    //             icon: _assets('${e.icon}_slt'),
    //             inactiveIcon: _assets('${e.icon}_nor'),
    //             title: e.title,
    //             activeForegroundColor: Colors.blue,
    //             inactiveForegroundColor: Colors.grey,
    //           ),
    //         ),
    //       )
    //       .toList(),
    //   navBarBuilder: (navBarConfig) {
    //     return RedirectBottomNavBar(
    //       navBarConfig: navBarConfig,
    //       onRedirected: (index) async {
    //         if (index == TabbarType.values.length - 1 &&
    //             !UserService.to.isLogined) {
    //           Get.dialog(AlertDialog(
    //             title: const Text('鉴权拦截处理'),
    //             content: const Text('点击按钮模拟登录操作，进入`个人中心`'),
    //             actions: [
    //               TextButton(
    //                 onPressed: () {
    //                   UserService.to.login();
    //                   Get.back();
    //                   controller.persistent.jumpToTab(index);
    //                 },
    //                 child: const Text('登录'),
    //               )
    //             ],
    //           ));
    //           return true;
    //         }
    //         return null;
    //       },
    //       navBarDecoration: const NavBarDecoration(
    //         color: Colors.white,
    //         // borderRadius: BorderRadius.circular(2),
    //       ),
    //     );
    //   },
    // );
  }
}

Widget _assets(String name) =>
    Image.asset('assets/images/$name.png', width: 26, height: 26);

/// 独立到每个页面，用脚本生成对应的路由名称
/// 路由名称
///
const String kRouteTabbar = '/tabbar';

/// AppPages : 注册 GetPage
/// 可以直接复制到 AppPages 文件中注册页面路由
///
/// ```
///    GetPage(
///       name: kRouteTabbar,
///       page: () => TabbarScaffold(),
///       binding: TabbarBinding(),
///     ),
/// ```
///
class TabbarBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<TabbarController>(
        () => TabbarController(),
      ),
      // tabbar 分页懒加载binding
      ...HomeBinding().dependencies(),
      ...MessageBinding().dependencies(),
      ...MineBinding().dependencies(),
    ];
  }
}
