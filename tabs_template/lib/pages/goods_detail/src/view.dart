import 'package:flutter/material.dart';
import 'package:tabs_template/app.dart';
import 'package:tabs_template/tabbar.dart';

import '../goods_detail.dart';

class GoodsDetailView extends BaseView<GoodsDetailController> {
  const GoodsDetailView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const AAppBar(title: 'NewsDetailView');
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(title: 'NewsDetailView'),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (controller.title > 300) {
              Get.toNamed(kRouteGoodsDetail, parameters: {
                'id': controller.title.toString(),
              });
            } else {
              TabbarController.to.switchTo(TabbarType.mine);
            }
          },
          child: Text(
              "NewsDetailView - ${Get.parameters['id']} - ${controller.title}"),
        ),
      ),
    );
  }
}
