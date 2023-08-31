import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin PagingMixin<T> {
  /// 初始页码
  int _initPage = 0;

  /// 刷新控制器
  PagingController<int, T> _pagingController =
      PagingController(firstPageKey: 0);
  PagingController<int, T> get pagingController => _pagingController;

  /// 当前页码
  int _page = 0;

  /// 控制刷新结束回调（异步处理）
  Completer? _refreshComplater;

  /// 数据列表
  List<T> get items => _pagingController.itemList ?? [];

  /// 挂载分页器
  /// `controller` 关联刷新状态管理的控制器
  /// `initPage` 初始页码值(分页起始页)
  void initPaging({int initPage = 0}) {
    // 重置分页器
    if (_initPage != initPage) {
      _initPage = initPage;
      _pagingController.dispose();
      _pagingController = PagingController(firstPageKey: initPage);
    }

    _pagingController.addPageRequestListener((pageKey) {
      fecthData(pageKey);
    });
  }

  /// 获取数据
  FutureOr fecthData(int page);

  /// 刷新数据
  Future onRefresh() {
    _refreshComplater = Completer();
    _pagingController.notifyPageRequestListeners(_initPage);
    return _refreshComplater!.future;
  }

  /// 获取数据前调用
  void beginLoad(int page) {
    _page = page;
  }

  /// 获取数据后调用
  /// `items` 列表数据
  /// `maxCount` 数据总数，如果为0则默认通过 `items` 有无数据判断是否可以分页加载, null为非分页请求
  /// `error` 错误信息
  void endLoad(
    List<T>? list, {
    int? maxCount,
    dynamic error,
  }) {
    if (_page == _initPage) {
      _refreshComplater?.complete();
      _refreshComplater = null;
    }

    if (list != null) {
      bool hasNoMore = true;

      // 刷新清空历史数据列表
      if (_page == _initPage && this.items.isNotEmpty) {
        updateItems([]);
      }

      // 默认没有总数量 `maxCount`，用获取当前数据列表是否有值判断
      // 默认有总数量 `maxCount`, 则判断当前请求数据list+历史数据items是否小于总数
      // bool hasNoMore = !((items.length + list.length) < maxCount);
      if (maxCount != null) {
        print(_pagingController.itemCount);
        hasNoMore = (list.length + _pagingController.itemCount) >= maxCount;
      }

      if (hasNoMore) {
        _pagingController.appendLastPage(list);
      } else {
        if (list.isNotEmpty) {
          _pagingController.appendPage(list, _page + 1);
        }
      }
    } else {
      _pagingController.error = error ?? '数据请求错误';
    }
  }

  /// 更新数据列表
  void updateItems(List<T> list) {
    _pagingController.itemList = list;
    // _pagingController.notifyListeners();
  }

  /// 重置加载的错误显示
  void retryLastFailedRequest() {
    _pagingController.retryLastFailedRequest();
  }
}

extension PagingControllerEx on PagingController {
  /// 列表数量
  int get itemCount => itemList?.length ?? 0;
}
