import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lifecycle/lifecycle.dart';

import '/app.dart';
import '/service.dart';
import 'package:flutter/material.dart';
// import 'package:lifecycle/lifecycle.dart';

abstract class BaseView<T extends BaseViewController>
    extends GetView<BaseViewController> {
  const BaseView({super.key});

  @override
  T get controller => Get.find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: buildBackgroundColor(context),
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      // 这里生命周期和原生的`onShow`有出入，具体逻辑差异需要自己特殊处理
      body: LifecycleWrapper(
        onLifecycleEvent: (event) {
          bool appeared = event == LifecycleEvent.active;
          // controller.onLifecycleEvent(event);
          if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
            return;
          }
          // && !controller.isPagedRefresh
          if (!controller.isOnInit && appeared && controller.isUseRepeatShow) {
            controller.onShowRequest();
          }
        },
        child: buildBody(context),
      ),
      bottomNavigationBar: Obx(
        () {
          return !AppService.to.connectivity.value
              ? const SizedBox.shrink()
              : buildBottomNavigationBar(context) ?? const SizedBox.shrink();
        },
      ),
    );

    return Obx(() {
      if (!AppService.to.connectivity.value) {
        // controller.reconnectStartTimer();
        return Scaffold(
          body: noNetworkView(context),
        );
      }

      // controller.reconnectStopTimer();
      return scaffold;
    });
  }

  bool get extendBody => false;
  bool get extendBodyBehindAppBar => false;
  bool? get resizeToAvoidBottomInset => null;

  /// 构建页面主体显示内容
  Widget buildBody(BuildContext context);

  /// 构建导航栏
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// 构建页面背景色
  Color? buildBackgroundColor(BuildContext context) => null;

  /// 构建页面底部显示内容
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// 没有网络连接的展示视图
  Widget noNetworkView(BuildContext context) {
    return NetworkAnomalyView(
      onTap: () async {
        try {
          AppService.to.isHideLoading = false;

          showLoading();
          await 2.delay();
          hideLoading();
          if (await InternetConnection().hasInternetAccess) {
            controller.onShowRequest();
            AppService.to.connectivity.value = true;
            // controller.tapRefreshCount++;
            // controller.update(['tapRefreshCount1', 'tapRefreshCount2']);
          }
        } catch (e) {
          hideLoading();
        }
      },
    );
  }
}

/// 通用导航栏
// class commonAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const commonAppBar({this.title, this.backgroundColor, super.key});

//   final String? title;
//   final Color? backgroundColor;

//   @override
//   Widget build(BuildContext context) {
//     return AAppBar(
//       title: title,
//       backgroundColor: backgroundColor,
//       actions: const [
//       ],
//     );
//   }

//   @override
//   Size get preferredSize =>
//       const Size.fromHeight(kMinInteractiveDimensionCupertino + 2);
// }

abstract class BaseViewController extends GetxController {
  /// 是否在初始化调用一次网络请求，`isUseRepeatShow` 之后生命周期函数自动调用请求
  /// (第一次不请求）
  bool isOnInit = true;

  /// 是否使用 `onShow` 逻辑
  bool isUseRepeatShow = true;

  /// 进入页面时间
  int timestamp = 0;

  /// 请求网络的定时器
  // Timer? _requestTimer;

  @override
  onInit() async {
    timestamp = DateTime.now().millisecondsSinceEpoch;
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    onShowRequest().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await 2.delay();
        isOnInit = false;
      });
    });
  }

  @override
  onClose() {
    // reconnectStopTimer();
    super.onClose();
  }

  /// 页面显示的回调，通过组件生命周期监听实现
  ///
  /// 默认进入页面会初始执行一次，以后每次页面显示的时候也会执行（如页面没被销毁的上级页面/根页面）
  ///
  /// 通常用于请求网络，刷新数据
  Future onShowRequest() async => null;

  /// 断网时重复请求网络，如果对应用使用网络监听则可以不使用
  // bool _isRepeatNetwork = false;
  // reconnectStartTimer() {
  //   reconnectStopTimer();
  //   _requestTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
  //     if (_isRepeatNetwork) {
  //       return;
  //     }
  //     AppService.to.isHideLoading = true;

  //     _isRepeatNetwork = true;
  //     await 2.delay();
  //     try {
  //       await onShowRepeatNetwork();
  //     } catch (e) {}
  //     _isRepeatNetwork = false;
  //   });
  // }

  // reconnectStopTimer() {
  //   AppService.to.isHideLoading = false;
  //   _requestTimer?.cancel();
  //   _requestTimer = null;
  // }
}
