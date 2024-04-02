import 'package:flutter/material.dart';

import '../../app.dart';
import 'controller.dart';

class MineView extends GetView<MineController> {
  const MineView({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: Text("MineView ${controller.count}"),
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
