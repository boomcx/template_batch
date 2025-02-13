import 'package:device_info_plus/device_info_plus.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

/// `event_bus`通知挂载
class AppNeedToLogin {}

class AppService extends GetxService {
  static AppService get to => Get.find();

  /// 全局通知
  static EventBus get bus => to._bus;
  final _bus = EventBus();

  /// 是否隐藏 loading
  bool isHideLoading = false;

  /// 获取设备的唯一编码
  SystemDevice device = SystemDevice();

  /// 控制页面的网络状态显示，不采用网络监听的方式动态修改，通过网络请求返回结果手动设置
  final connectivity = true.obs;

  /// 网络监听
  // StreamSubscription<InternetStatus>? listener;

  @override
  void onInit() async {
    super.onInit();
    initDeviceInfo();
    // initConnectivity();
  }

  /// 网络连接
  // initConnectivity() async {
  //   listener =
  //       InternetConnection().onStatusChange.listen((InternetStatus status) {
  //     switch (status) {
  //       case InternetStatus.connected:
  //         isConnected.value = true;
  //         connectedTimes++;
  //         break;
  //       case InternetStatus.disconnected:
  //         isConnected.value = false;
  //         break;
  //     }
  //   });
  // }

  /// 初始化设备信息
  initDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (GetPlatform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = device.copyWith(
        name: androidInfo.model,
        identifier: androidInfo.id,
        systemVersion: '${androidInfo.version.sdkInt}',
      );
    } else if (GetPlatform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device = device.copyWith(
        name: iosInfo.name,
        identifier: iosInfo.identifierForVendor ?? 'ios_device',
        systemVersion: iosInfo.systemVersion,
      );
    }

    // print(device.toString());
  }
}

/// 系统设备信息
class SystemDevice {
  /// 设备名称
  final String name;

  /// 系统版本
  final String systemVersion;

  /// 唯一标识
  final String identifier;
  SystemDevice({
    this.name = '',
    this.systemVersion = '',
    this.identifier = '',
  });

  SystemDevice copyWith({
    String? name,
    String? systemVersion,
    String? identifier,
  }) {
    return SystemDevice(
      name: name ?? this.name,
      systemVersion: systemVersion ?? this.systemVersion,
      identifier: identifier ?? this.identifier,
    );
  }

  @override
  String toString() =>
      'SystemDevice(name: $name, systemVersion: $systemVersion, identifier: $identifier)';
}
