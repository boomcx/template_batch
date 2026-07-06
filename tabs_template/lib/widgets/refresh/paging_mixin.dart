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
/// 2. 实现 `fetchData(page)`
/// 3. 页面绑定 `pagingController`
/// 4. 刷新时调用 `onRefresh()`
///
/// `fetchData` 返回 `null` 时会按空页处理；若服务端 total 不准确，
/// 空页也会停止继续翻页，避免无效循环请求。
mixin PagingMixin<T> on GetxController {
  /// 初始页码。
  int get initPage => 1;

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
        // 如果上一页为空，停止翻页
        if (state.lastPageIsEmpty) return null;

        // 如果已达到总数，停止翻页
        final total = requestRes?.total;
        if (total != null && items.length >= total) return null;

        // 首次请求时 keys 为空，返回 initPage；后续返回上一页 + 1
        final keys = state.keys;
        final nextPageKey =
            (keys != null && keys.isNotEmpty) ? keys.last + 1 : initPage;
        print('getNextPageKey - -------- $nextPageKey');
        return nextPageKey;
      },
      fetchPage: (pageKey) async {
        // 双重检查：如果已达到总数，直接返回空
        final total = requestRes?.total;
        if (total != null && items.length >= total) {
          return [];
        }

        print('pageKeypageKeypageKey - $pageKey');
        final result =
            await fetchData(pageKey) ?? PagedListRes<T>([], items.length);
        requestRes = result;

        return result.items;
      },
    );

    _pagingController.addListener(() {
      fetchDataStateChanged(_pagingController.status);
    });
  }

  @override
  onClose() {
    _pagingController.dispose();
    refreshController.dispose();
    super.onClose();
  }

  /// 子类实现分页请求。
  FutureOr<PagedListRes<T>?> fetchData(int page);

  /// 请求状态回调。
  void fetchDataStateChanged(PagingStatus status) {}

  /// 重新拉取第一页数据。
  Future<void> onRefresh() async {
    requestRes = null;
    _pagingController.refresh();
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
}
