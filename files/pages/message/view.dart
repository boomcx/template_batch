import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({Key? key}) : super(key: key);

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("MessageView"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("message")),
      body: SafeArea(
        child: _buildView(),
      ),
    );
  }
}
