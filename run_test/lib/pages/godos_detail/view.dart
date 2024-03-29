import 'dart:math';

import 'package:flutter/material.dart';

import '../../app.dart';
import 'godos_detail.dart';

class GodosDetailView extends GetView<GodosDetailController> {
  const GodosDetailView({
    super.key,
    required this.id,
  });

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
