import 'package:flutter/material.dart';
import 'package:tabs_template/app.dart';

import '../godos_detail/godos_detail.dart';
import 'controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AAppBar(title: 'HomeView', isRootNavigator: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HomeView',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(kRouteGodosDetail, parameters: {
                  'id': '99999',
                });
              },
              child: const Text('news detail'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await NetRepository.client.videoList(1, 10);
                  showMessage('请求成功');
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
      ),
    );
  }
}
