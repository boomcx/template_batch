import 'package:flutter/material.dart';

import '../action_state.dart';
import 'empty_data_view.dart';

/// 通过数据状态修改页面显示
class DataScaffold extends StatelessWidget {
  const DataScaffold({
    Key? key,
    required this.state,
    this.loadingWidget,
    required this.child,
    this.emptyWidget,
    this.emptyIcon,
    this.emptyTip,
    this.emptyAttachChild,
    this.onReload,
  }) : super(key: key);

  /// 数据状态
  final ActionState state;

  /// 如果加载成功的正常显示
  final Widget child;

  /// 加载组件
  final Widget? loadingWidget;

  /// 数据为空的显示图
  final Widget? emptyWidget;

  final Widget? emptyIcon;
  final String? emptyTip;
  final Widget? emptyAttachChild;
  final VoidCallback? onReload;

  @override
  Widget build(BuildContext context) {
    final emptyWidget = this.emptyWidget ??
        DefaultEmptyDataView(
          icon: emptyIcon,
          text: emptyTip,
          onPressed: onReload,
          attachView: emptyAttachChild,
        );

    return state.when(
      initial: () => child,
      running: () => loadingWidget ?? const LoadingPlaceholder(),
      success: () => child,
      failure: (_) => emptyWidget,
    );

    // if (state is Running && isEmpty()) {
    //   return loadingWidget ?? const LoadingPlaceholder();
    // } else if (state is Failure) {
    //   if (onRefresh == null) return emptyWidget;
    //   return RefreshControl(
    //     // key: const ValueKey('empty'),
    //     onRefresh: onRefresh,
    //     childBuilder: (context, physics, constraints) {
    //       return SingleChildScrollView(
    //         physics: physics,
    //         child: SizedBox(
    //           height: constraints.maxHeight,
    //           child: emptyWidget,
    //         ),
    //       );
    //     },
    //   );
    // } else if (state is Success && isEmpty()) {
    //   if (onRefresh == null) return emptyWidget;
    //   return RefreshControl(
    //     // key: const ValueKey('empty'),
    //     onRefresh: onRefresh,
    //     childBuilder: (context, physics, constraints) {
    //       return SingleChildScrollView(
    //         physics: physics,
    //         child: SizedBox(
    //           height: constraints.maxHeight,
    //           child: emptyWidget,
    //         ),
    //       );
    //     },
    //   );
    // }
    // return child;
  }
}
