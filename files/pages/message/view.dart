import 'package:flutter/material.dart';

import '../../app.dart';
import 'controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});

  // 主视图
  Widget _buildView() {
    return Center(
      child: Text("MessageView ${controller.count}"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(title: 'MessageView'),
      body: SafeArea(
        child: _buildView(),
      ),
    );
  }
}
