import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

import 'package:tabs_template/app.dart';

class MessageController extends BaseViewController with PagingMixin<String> {
  final count = Random().nextInt(999);

  @override
  get initPage => 0;

  @override
  FutureOr<PagedListRes<String>?> fetchData(int page) async {
    debugPrint('page: $page');
    await 2.delay();
    return PagedListRes(
        page == 1 ? List.generate(10, (index) => 'item $index') : [], 10);
    // return List.generate(30, (index) => 'item $index');
  }
}
