import 'package:flutter/material.dart';
import '/app.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MineView extends GetView<MineController> {
  const MineView({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("MineView"),
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
