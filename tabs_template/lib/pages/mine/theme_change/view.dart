import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../support_files/theme.dart';
import 'theme_change.dart';

class ThemeChangeView extends GetView<ThemeChangeController> {
  const ThemeChangeView({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("ThemeChangeView ").paddingOnly(bottom: 20),
          Text("${Get.parameters['id']} count").paddingOnly(bottom: 20),
          ElevatedButton(
            onPressed: () {
              ThemeManager.to.changeDarkMode();
            },
            child: const Text('changeDarkMode'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.bottomSheet(
                const PopView(),
              );
            },
            child: const Text('popview and pushReplace ThemeChangeView'),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     ThemeManager.to.changeTheme('dark');
          //   },
          //   child: const Text('changeMode - dark'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     ThemeManager.to.changeTheme('light');
          //   },
          //   child: const Text('changeMode - light'),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("theme_change")),
      body: SafeArea(
        child: _buildView(),
      ),
    );
  }
}

class PopView extends StatelessWidget {
  const PopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 200.w,
      width: double.infinity,
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          Get.offNamed(kRouteThemeChange, parameters: {
            /// 携带参数后路由地址会变化 `kRouteThemeChange?id=99999`
            /// 可以实现弹窗后进行重复页面跳转（移除当前页）
            'id': Random().nextInt(10000000).toString(),
          });
        },
        child: const Text('pushReplace ThemeChangeView'),
      ),
    );
  }
}
