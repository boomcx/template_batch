import 'package:flutter/material.dart';
import 'package:tabs_template/app.dart';
import 'package:tabs_template/tabbar.dart';

import '../goods_detail.dart';

class GoodsDetailView extends BaseRecreateView<GoodsDetailController> {
  const GoodsDetailView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const AAppBar(title: 'NewsDetailView');
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Text("count - ${controller.count} "),
            ),
            GetBuilder<GoodsDetailController>(
              global: false,
              assignId: false,
              autoRemove: false,
              init: controller,
              id: "count2",
              builder: (_) {
                return Text("count2 - ${controller.count2} ");
              },
            ),
            ElevatedButton(
              onPressed: () {
                // if (controller.title > 300) {
                //   Get.toNamed(kRouteGoodsDetail, parameters: {
                //     'id': controller.title.toString(),
                //     'tag': UniqueKey().toString(),
                //   });
                // } else {
                //   TabbarController.to.switchTo(TabbarType.mine);
                // }
                controller.refresh();
              },
              child: Text("refresh"),
            ),
            ElevatedButton(
              onPressed: () {
                // if (controller.title > 300) {
                Get.toNamed(kRouteGoodsDetail, parameters: {
                  'id': controller.title.toString(),
                  'tag': UniqueKey().toString(),
                });
                // } else {
                // TabbarController.to.switchTo(TabbarType.mine);
                // }
              },
              child: Text("next"),
            ),
          ],
        ),
      ),
    );
  }
}
