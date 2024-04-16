import 'dart:math';

import 'package:flutter/material.dart';

import '/tabbar.dart';

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
            final rand = Random().nextInt(100);

            if (rand > 50) {
              Get.toNamed(kRouteGodosDetail, parameters: {
                'id': rand.toString(),
              });
            } else {
              TabbarController.to.jumpToTab(TabbarType.mine);
            }
          },
          child: Text("NewsDetailView ${controller.title}"),
        ),
      ),
    );
  }
}
