import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import 'paging_mixin.dart';
import 'refresh_header.dart';

/// 刷新配置
class PullRefreshControl extends StatelessWidget {
  const PullRefreshControl({
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
      // controller: pagingMixin.pagingController,
      header: header ??
          RefreshHeader(
            clamping: locatorMode,
            position: locatorMode
                ? IndicatorPosition.locator
                : IndicatorPosition.above,
          ),
      onRefresh: pagingMixin.onRefresh,
      childBuilder: childBuilder,
    );
  }
}
