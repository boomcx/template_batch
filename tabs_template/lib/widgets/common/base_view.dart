import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lifecycle/lifecycle.dart';

import 'package:tabs_template/app.dart';
import 'package:tabs_template/service.dart';
import 'package:flutter/material.dart';
// import 'package:lifecycle/lifecycle.dart';

/// 通用页面壳层。
///
/// 子类通常只需要实现 `buildBody`，可选实现 `buildAppBar` 和
/// `onShowRequest`。
mixin BaseViewInterface<T extends BaseViewController> {
  /// 页面控制器。
  T get baseController;

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

  /// 断网占位页，点击后会重新探测网络并刷新。
  Widget noNetworkView(BuildContext context) {
    return NetworkAnomalyView(
      onTap: () async {
        try {
          AppService.to.isHideLoading = false;

          showLoading();
          await 2.delay();
          hideLoading();
          if (await InternetConnection().hasInternetAccess) {
            baseController.onShowRequest();
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

  /// 公共 build 逻辑。
  Widget buildCommon(BuildContext context) {
    final scaffold = Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: buildBackgroundColor(context),
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      // 页面重新激活时触发刷新。
      body: LifecycleWrapper(
        onLifecycleEvent: (event) {
          bool appeared = event == LifecycleEvent.active;
          // controller.onLifecycleEvent(event);
          if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
            return;
          }
          // && !controller.isPagedRefresh
          if (!baseController.isOnInit &&
              appeared &&
              baseController.isUseRepeatShow) {
            baseController.onShowRequest();
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
}

/// 普通 `GetView` 页面基类。
///
/// 适合单实例控制器页面。

abstract class BaseView<T extends BaseViewController> extends GetView<T>
    with BaseViewInterface {
  const BaseView({super.key});

  @override
  T get baseController => controller;

  @override
  Widget build(BuildContext context) => buildCommon(context);
}

/// `GetWidget` 页面基类，配合 `Bind.create()` 使用。
///
/// 使用方式：
/// ```
/// class MyPage extends BaseReceateView<HomePageController> {}
/// ```
/// Binding:
/// ```
/// class MyPageBinding extends Binding {
///   @override
///   List<Bind> dependencies() {
///     return [
///       Bind.create<MyPageController>(
///         (_) => MyPageController(),
///       )
///     ];
///   }
/// }
/// ```
///
abstract class BaseRecreateView<T extends BaseViewController>
    extends GetWidget<T> with BaseViewInterface {
  const BaseRecreateView({super.key});

  @override
  T get baseController => controller;

  @override
  Widget build(BuildContext context) => buildCommon(context);
}

abstract class BaseViewController extends GetxController {
  /// 首次进入后是否跳过一次重复刷新。
  bool isOnInit = true;

  /// 是否启用页面回前台刷新。
  bool isUseRepeatShow = true;

  /// 进入页面时间戳。
  int timestamp = 0;

  /// 可选的重复请求定时器。
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

  // @override
  // onClose() {
  //   // reconnectStopTimer();
  //   super.onClose();
  // }

  /// 页面显示回调。
  ///
  /// 默认首次进入会执行一次，后续在页面重新激活时也会执行。
  /// 通常在这里请求接口或刷新数据。
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
