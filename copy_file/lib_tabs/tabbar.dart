import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'app.dart';
import 'service.dart';

import './pages/message/message.dart';
import '/pages/home/home.dart';
import '/pages/mine/mine.dart';
import 'widgets/common/redirect_bottom_bar.dart';

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
    return 'home';
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

  final persistent = PersistentTabController();

  /// 指定切换到根路径
  void jumpToTab([TabbarType type = TabbarType.home]) {
    Get.offAllNamed(kRouteTabbar);
    persistent.jumpToTab(TabbarType.values.indexOf(type));
  }
}

class TabbarScaffold extends GetView<TabbarController> {
  const TabbarScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller.persistent,
      screenTransitionAnimation: const ScreenTransitionAnimation.none(),
      tabs: TabbarType.values
          .map(
            (e) => PersistentTabConfig(
              screen: e.body,
              item: ItemConfig(
                icon: _assets('${e.icon}_slt'),
                inactiveIcon: _assets('${e.icon}_nor'),
                title: e.title,
                activeForegroundColor: Colors.blue,
                inactiveForegroundColor: Colors.grey,
              ),
            ),
          )
          .toList(),
      navBarBuilder: (navBarConfig) {
        return RedirectBottomNavBar(
          navBarConfig: navBarConfig,
          onRedirected: (index) async {
            if (index == TabbarType.values.length - 1 &&
                !UserService.to.isLogined) {
              Get.dialog(AlertDialog(
                title: const Text('鉴权拦截处理'),
                content: const Text('点击按钮模拟登录操作，进入`个人中心`'),
                actions: [
                  TextButton(
                    onPressed: () {
                      UserService.to.login();
                      Get.back();
                      controller.persistent.jumpToTab(index);
                    },
                    child: const Text('登录'),
                  )
                ],
              ));
              return true;
            }
            return null;
          },
          navBarDecoration: const NavBarDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(2),
          ),
        );
      },
    );
  }
}

Widget _assets(String name) =>
    Image.asset('assets/images/ic_$name.png', width: 26, height: 26);

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
