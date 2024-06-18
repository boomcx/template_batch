import 'package:flutter/material.dart';

import '/tabbar.dart';

import '../../app.dart';
import 'godos_detail.dart';

class GodosDetailView extends GetView<GodosDetailController> {
  const GodosDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(title: 'NewsDetailView'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (controller.title > 300) {
              Get.toNamed(kRouteGodosDetail, parameters: {
                'id': controller.title.toString(),
              });
            } else {
              TabbarController.to.jumpToTab(TabbarType.mine);
            }
          },
          child: Text(
              "NewsDetailView - ${Get.parameters['id']} - ${controller.title}"),
        ),
      ),
    );
  }
}
