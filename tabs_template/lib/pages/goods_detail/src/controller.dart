import 'dart:math';

import '/app.dart';

class GoodsDetailController extends BaseViewController {
  final title = Random().nextInt(999);

  final count = 0.obs;
  int count2 = 0;

  refresh() {
    count.value = Random().nextInt(9999);

    count2 = Random().nextInt(9999);
    update(['count2']);
  }
}
