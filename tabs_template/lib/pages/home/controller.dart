import 'dart:math';

import 'package:tabs_template/app.dart';

class HomeController extends BaseViewController {
  final count = Random().nextInt(999).obs;

  @override
  Future onShowRequest() async {
    // 发起请求
  }
}
