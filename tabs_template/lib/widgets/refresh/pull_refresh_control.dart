import 'package:flutter/material.dart';

import 'package:easy_refresh/easy_refresh.dart';

import 'package:tabs_template/widgets/refresh/paging_mixin.dart';

/// 刷新配置
class PageRefreshControl extends StatelessWidget {
  const PageRefreshControl({
    super.key,
    required this.pagingMixin,
    required this.childBuilder,
    this.header,
    this.locatorMode = false,
  });

  final Header? header;

  /// 列表视图
  final ERChildBuilder childBuilder;

  /// 分页控制器
  final PagingMixin pagingMixin;

  /// 是否固定刷新偏移
  final bool locatorMode;

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      controller: pagingMixin.refreshController,
      header: header,
      onRefresh: pagingMixin.onRefresh,
      childBuilder: childBuilder,
    );
  }
}
