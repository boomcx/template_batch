import 'dart:math';

import 'package:flutter/material.dart';
import '/app.dart';
import 'package:get/get.dart';

import 'godos_detail.dart';

class GodosDetailView extends GetView<GodosDetailController> {
  const GodosDetailView({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(title: 'NewsDetailView'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(kRouteGodosDetail, parameters: {
              'id': Random().nextInt(100).toString(),
            });
          },
          child: Text("NewsDetailView ${controller.title}"),
        ),
      ),
    );
  }
}
