import 'package:flutter/material.dart';
import 'package:tabs_template/pages/goods_detail/goods_detail.dart';
import 'package:tabs_template/pages/home/home.dart';
import '/app.dart';

import 'controller.dart';

class HomeView extends BaseView<HomeController> {
  const HomeView({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const AAppBar(title: 'HomeView', isRootNavigator: true);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'HomeView',
            style: TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(kRouteGoodsDetail, parameters: {
                'id': '99999',
              });
            },
            child: const Text('news detail'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await NetRepository.client.videoList(1, 10);
                // showMessage('请求成功');
              } catch (e) {}
            },
            child: const Text('successful request'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await NetRepository.client.logout();
              } catch (e) {
                // showMessage('接口异常: $e');
              }
            },
            child: const Text('failed request'),
          )
        ],
      ),
    );
  }
}
