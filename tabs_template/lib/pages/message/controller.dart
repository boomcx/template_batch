import 'dart:async';
import 'dart:math';

import 'package:tabs_template/app.dart';

class MessageController extends BaseViewController with PagingMixin<String> {
  final count = Random().nextInt(999);

  @override
  FutureOr<PagedListRes<String>?> fecthData(int page) async {
    print('page: $page');
    await 2.delay();
    return PagedListRes(List.generate(20, (index) => 'item $index'), 50);
    // return List.generate(30, (index) => 'item $index');
  }
}
