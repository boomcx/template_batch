import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tabs_template/models/paging_index.dart';

/// 分页控制器
///
/// `on GetxController` 简化使用过程
mixin PagingMixin<T> on GetxController {
  /// 初始页码
  int initPage = 1;

  /// 当前页码请求返回的分页数据
  PagingIndex<T>? pagingData;

  /// 全部的列表数据
  List<T> get items => _pagingController.items ?? [];

  /// 页面状态控制
  ///
  /// `infinite_scroll_pagination` 用列表超屏距离和 `state.hasNextPage` 判断是否需要进行下一次请求
  /// 所以当数据渲染没有超屏且 `hasNextPage` 为true时，
  /// 插件会尝试多次调用 `fetchPage` 获取数据，以满足插件限制条件
  late PagingController<int, T> _pagingController;
  PagingController<int, T> get pagingController => _pagingController;

  /// 预置刷新控制器
  EasyRefreshController refreshController = EasyRefreshController();

  /// on GetxController 简化使用过程
  ///
  /// 也可以指定其他数据包含生命周期函数的类别，eg `State<T extends StatefulWidget> `
  @override
  void onInit() {
    super.onInit();

    _pagingController = PagingController<int, T>(
      getNextPageKey: (state) {
        if (pagingData == null) {
          return initPage;
        }

        // 判断服务器数据是否全部获取
        if (pagingData!.total > items.length) {
          final page = (state.keys?.last ?? initPage);
          return page + 1;
        }
        // 返回null，在 `pagingController` 中禁止进行下一次请求
        return null;
      },
      fetchPage: (pageKey) async {
        pagingData = await fecthData(pageKey);
        return Future.value(pagingData?.list as List<T>? ?? []);
      },
    );

    _pagingController.addListener(() {
      fecthDataStateChanged(_pagingController.status);
    });
  }

  @override
  onClose() {
    _pagingController.dispose();
    super.onClose();
  }

  /// 子类继承实现的请求方法
  FutureOr<PagingIndex<T>> fecthData(int page);

  /// 请求数据中的状态监听
  void fecthDataStateChanged(PagingStatus status) {}

  /// 刷新数据
  Future onRefresh() async {
    pagingData = null;
    _pagingController.status;
    _pagingController.refresh();
  }

  /// 手动外部更新数据列表（整体替换）
  void updateItems(List<T> list) {
    _pagingController.value = _pagingController.value.copyWith(
      pages: [list],
      keys: [initPage],
    );
  }
}
