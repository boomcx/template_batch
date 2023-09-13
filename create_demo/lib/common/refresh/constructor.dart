import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'paging_mixin.dart';
import 'pull_refresh_control.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'refresh_footer.dart';

/// 快速构建 `ListView` 形式的分页列表
/// 其他详细参数查看 [ListView]
class SpeedyPagedList<T> extends StatelessWidget {
  const SpeedyPagedList({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.scrollController,
    this.padding,
    this.header,
    this.locatorMode = false,
    this.emptyView,
    this.loadingView,
    this.animateTransitions = false,
  }) : _separatorBuilder = null;

  const SpeedyPagedList.separator({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    this.scrollController,
    this.padding,
    this.header,
    this.locatorMode = false,
    this.emptyView,
    this.loadingView,
    this.animateTransitions = false,
  }) : _separatorBuilder = separatorBuilder;

  final PagingMixin<T> controller;

  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  final Header? header;

  final bool locatorMode;

  /// 参照 [ScrollView.controller].
  final ScrollController? scrollController;

  /// 参照 [ListView.itemExtent].
  final EdgeInsetsGeometry? padding;

  /// 参照 [ListView.separator].
  final IndexedWidgetBuilder? _separatorBuilder;

  final WidgetBuilder? loadingView;
  final WidgetBuilder? emptyView;
  final bool animateTransitions;

  @override
  Widget build(BuildContext context) {
    return PullRefreshControl(
      pagingMixin: controller,
      header: header,
      locatorMode: locatorMode,
      childBuilder: (context, physics) {
        return _separatorBuilder != null
            ? PagedListView<int, T>.separated(
                physics: physics,
                padding: padding,
                pagingController: controller.pagingController,
                builderDelegate: pagedChildDelegate(
                  (context, item, index) {
                    return itemBuilder.call(context, index, item);
                  },
                  loadingView: loadingView,
                  emptyView: emptyView,
                  animateTransitions: animateTransitions,
                ),
                separatorBuilder: _separatorBuilder!,
              )
            : PagedListView<int, T>(
                physics: physics,
                padding: padding,
                pagingController: controller.pagingController,
                builderDelegate: pagedChildDelegate(
                  (context, item, index) {
                    return itemBuilder.call(context, index, item);
                  },
                  loadingView: loadingView,
                  emptyView: emptyView,
                  animateTransitions: animateTransitions,
                ),
              );
      },
    );
  }
}

/// 快速构建 `GridView` 形式的分页列表
/// 其他详细参数查看 [GridView]
// class SpeedyPagedGrid<T> extends StatelessWidget {
//   const SpeedyPagedGrid({
//     super.key,
//     required this.controller,
//     required this.itemBuilder,
//     required this.gridDelegate,
//     this.scrollController,
//     this.padding,
//     this.header,
//     this.locatorMode = false,
//     this.refreshOnStart = true,
//     this.startRefreshHeader,
//   });

//   final PagingMixin controller;
//   final Widget Function(BuildContext context, int index, T item) itemBuilder;

//   final Header? header;

//   final bool refreshOnStart;
//   final Header? startRefreshHeader;
//   final bool locatorMode;

//   /// 参照 [ScrollView.controller].
//   final ScrollController? scrollController;

//   /// 参照 [ListView.itemExtent].
//   final EdgeInsetsGeometry? padding;

//   /// 参照 [GridView.gridDelegate].
//   final SliverGridDelegate gridDelegate;

//   @override
//   Widget build(BuildContext context) {
//     return PullRefreshControl(
//       pagingMixin: controller,
//       header: header,
//       refreshOnStart: refreshOnStart,
//       startRefreshHeader: startRefreshHeader,
//       locatorMode: locatorMode,
//       childBuilder: (context, physics) {
//         return GridView.builder(
//           physics: physics,
//           padding: padding,
//           controller: scrollController,
//           gridDelegate: gridDelegate,
//           itemCount: controller.pagingController.itemCount,
//           itemBuilder: (context, index) {
//             final item = controller.items[index];
//             return itemBuilder.call(context, index, item);
//           },
//         );
//       },
//     );
//   }
// }
// 