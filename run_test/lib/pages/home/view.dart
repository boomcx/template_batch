import 'package:flutter/material.dart';
import '../../app.dart';

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
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(kRouteGodosDetail, parameters: {
                  'id': '99999',
                });
              },
              child: const Text('news detail'),
            )
          ],
        ),
      ),
    );
  }
}
