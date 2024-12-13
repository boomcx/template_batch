import 'dart:math';

import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = Random().nextInt(999).obs;

  @override
  void onInit() async {
    super.onInit();
  }
}
