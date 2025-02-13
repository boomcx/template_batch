import 'package:flutter/material.dart';

import '/pages/mine/theme_change/theme_change.dart';

import '../../app.dart';
import 'controller.dart';

class MineView extends BaseView<MineController> {
  const MineView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const AAppBar(title: 'MineView', isRootNavigator: true);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("MineView ${controller.count}").paddingOnly(bottom: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(kRouteThemeChange);
              // Get.toNamed(kRouteGoodsDetail, parameters: {
              //   'id': '99999',
              // });
            },
            child: const Text('changeDarkMode'),
          ),
        ],
      ),
    );
  }
}
