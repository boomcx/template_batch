import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// 分页接口返回值。
class PagedListRes<T> {
  /// 当前页列表。
  final List<T> items;

  /// 数据总数。
  final int total;

  /// [items] 允许传空，内部统一转为空列表，避免分页插件重复请求第一页。
  PagedListRes(
    List<T>? items,
    this.total,
  ) : items = items ?? [];
}

/// 分页控制器混入。
///
/// 使用方式：
/// 1. 控制器 `with PagingMixin<T>`
/// 2. 实现 `fecthData(page)`
/// 3. 页面绑定 `pagingController`
/// 4. 刷新时调用 `onRefresh()`
///
/// `fecthData` 返回 `null` 时会按空页处理；若服务端 total 不准确，
/// 空页也会停止继续翻页，避免无效循环请求。
mixin PagingMixin<T> on GetxController {
  /// 初始页码。
  int initPage = 1;

  /// 最近一次接口返回。
  PagedListRes<T>? requestRes;

  /// 已加载的全部列表数据。
  List<T> get items => _pagingController.items ?? [];

  /// 列表状态控制器。
  ///
  /// 插件会根据 `hasNextPage` 自动继续拉取下一页。
  late PagingController<int, T> _pagingController;
  PagingController<int, T> get pagingController => _pagingController;

  /// 下拉刷新控制器。
  EasyRefreshController refreshController = EasyRefreshController();

  /// 初始化分页控制器。
  @override
  void onInit() {
    super.onInit();

    _pagingController = PagingController<int, T>(
      getNextPageKey: (state) {
        if (requestRes == null) {
          return initPage;
        }

        return _getNextPageKey(state);
      },
      fetchPage: (pageKey) async {
        final result =
            await fecthData(pageKey) ?? PagedListRes<T>([], items.length);
        requestRes = result;
        return result.items;
      },
    );

    _pagingController.addListener(() {
      fecthDataStateChanged(_pagingController.status);
    });
  }

  @override
  onClose() {
    _pagingController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  /// 子类实现分页请求。
  FutureOr<PagedListRes<T>?> fecthData(int page);

  /// 请求状态回调。
  void fecthDataStateChanged(PagingStatus status) {}

  /// 重新拉取第一页数据。
  Future<void> onRefresh() async {
    requestRes = null;
    _pagingController.refresh();
    return _fetchFirstPage();
  }

  /// 直接替换当前列表数据。
  void updateItems(List<T> list) {
    requestRes = PagedListRes<T>(list, list.length);
    _pagingController.value = _pagingController.value.copyWith(
      pages: [list],
      keys: [initPage],
      hasNextPage: false,
      error: null,
      isLoading: false,
    );
  }

 

  /// 主动触发第一页请求，并等待分页状态结束，便于下拉刷新正确收尾。
  Future<void> _fetchFirstPage() {
    final completer = Completer<void>();

    void completeIfFinished() {
      final state = _pagingController.value;
      final hasResult =
          state.pages != null || state.error != null || !state.hasNextPage;
      if (!state.isLoading && hasResult && !completer.isCompleted) {
        _pagingController.removeListener(completeIfFinished);
        completer.complete();
      }
    }

    _pagingController.addListener(completeIfFinished);
    _pagingController.fetchNextPage();
    completeIfFinished();

    return completer.future;
  }
}
