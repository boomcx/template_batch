import 'package:flutter/material.dart';

import '/pages/mine/theme_change/theme_change.dart';

import '../../app.dart';
import 'controller.dart';

class MineView extends GetView<MineController> {
  const MineView({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("MineView ${controller.count}").paddingOnly(bottom: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(kRouteThemeChange);
            },
            child: const Text('changeDarkMode'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(title: 'MineView', isRootNavigator: true),
      body: SafeArea(
        child: _buildView(),
      ),
    );
  }
}
