import 'dart:async';
import 'dart:math';

import 'package:tabs_template/app.dart';
import 'package:tabs_template/models/paging_index.dart';

class MessageController extends BaseViewController with PagingMixin<String> {
  final count = Random().nextInt(999);

  @override
  FutureOr<PagingIndex<String>> fecthData(int page) async {
    print('page: $page');
    await 2.delay();
    return PagingIndex(
        list: List.generate(20, (index) => 'item $index'), total: 50);
    // return List.generate(30, (index) => 'item $index');
  }
}
