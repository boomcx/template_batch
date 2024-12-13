import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class TestView extends GetView<TestController> {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("test")),
      body: Center(
        child: Text("TestView"),
      ),
    );
  }
}
