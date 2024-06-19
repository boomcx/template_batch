import 'dart:math';

import 'package:get/get.dart';

import '../../service.dart';

class HomeController extends GetxController {
  final count = Random().nextInt(999);


  /// 是否建立网络连接
  var connectivityResult = AppService.to.connectivityResult;
}
