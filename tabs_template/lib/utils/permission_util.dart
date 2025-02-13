// ignore_for_file: collection_methods_unrelated_type

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import '/support_files/text_style.dart';
import '/widgets/dialogs/common_alert.dart';
import '/service.dart';

class PermissionUtil {
  static PermissionUtil? _instance;

  PermissionUtil._internal() {
    _instance = this;
  }

  ///工厂构造函数
  factory PermissionUtil() => _instance ??= PermissionUtil._internal();

  /// 申请定位权限
  Future<bool> requestLocation({
    isUploadDevice = true,
  }) async {
    bool hasPermission = await requestPermissions(
      [
        Permission.locationWhenInUse,
      ],
      message: permissionMessage[Permission.location],
      // maskTitle: "定位权限说明",
      // maskContent: '便于获取您的位置信息，匹配附近主播信息数据。',
    );

    // 上传设备信息
    if (isUploadDevice) {}
    return hasPermission;
  }

  Future<bool> requestFirstLocation() async {
    final status = await Permission.location.request();

    return status.isGranted;
  }

  /// 申请麦克风
  // Future<bool> requestMicrophone() async {
  //   bool hasPermission = await requestPermissions(
  //     [Permission.microphone, Permission.storage],
  //     message: _messages[Permission.microphone],
  //   );
  //   return hasPermission;
  // }

  // /// 申请存储权限
  // Future<bool> requestStorage() async {
  //   bool hasPermission = await requestPermissions(
  //     [Permission.storage],
  //     message: permissionMessage[Permission.storage],
  //     // maskTitle: "存储权限说明",
  //     // maskContent: '便于您使用图片保存写入相册功能。',
  //   );
  //   return hasPermission;
  // }

  // /// 申请麦克风、存储权限
  // Future<bool> requestMicrophoneAndAudio() async {
  //   bool hasPermission = await requestPermissions(
  //     [Permission.microphone, Permission.audio],
  //     message: permissionMessage[Permission.microphone],
  //     // maskTitle: "麦克风权限说明",
  //     // maskContent: '便于您使用该功能录制发送语音消息，及语音房间畅聊功能。',
  //     bothGranted: false,
  //   );
  //
  //   return hasPermission;
  // }

  /// 申请相机、相册权限
  // Future<bool> requestCameraAndPhoto() async {
  //   bool hasPermission = await requestPermissions(
  //     [Permission.camera, Permission.storage, Permission.photos],
  //     message:
  //         'You have denied camera/album permissions, do you want to go to Settings to open?',
  //   );
  //   return hasPermission;
  // }

  /// 相册权限
  Future<bool> requestPhoto() async {
    // var permissions = [Permission.storage, Permission.photos];
    var permissions = [Permission.photos];
    if (Platform.isAndroid) {
      final version = double.tryParse(AppService.to.device.systemVersion) ?? 0;
      if (version <= 32) {
        // permissions = [Permission.storage];
      } else {
        permissions = [Permission.photos];
      }
    }

    bool hasPermission = await requestPermissions(
      permissions,
      message: permissionMessage[Permission.photos],
      bothGranted: false,
      // maskTitle: '存储权限/相册权限说明',
      // maskContent: '便于您使用该功能从相册中选择照片/图片上传及用于修改头像、图片保存、意见反馈等场景中读取和写入相册。',
    );
    // 上传设备信息
    // ConfigService.to.devicePhotos();
    return hasPermission;
  }

  /// 申请日历
  Future<bool> requestCalendar({
    isUploadDevice = true,
  }) async {
    bool hasPermission = await requestPermissions(
      // [Permission.camera, Permission.storage],
      [Permission.calendarFullAccess],
      bothGranted: false,
      message: permissionMessage[Permission.calendarFullAccess],
      // maskTitle: '日历权限说明',
      // maskContent: '便于您使用该功能拍摄照片/图片上传及用于修改头像、图片保存、意见反馈等场景。',
    );
    // 上传设备信息
    if (isUploadDevice) {}
    return hasPermission;
  }

  /// 申请相机
  Future<bool> requestCamera({
    isUploadDevice = true,
  }) async {
    bool hasPermission = await requestPermissions(
      [Permission.camera],
      bothGranted: false,
      message: permissionMessage[Permission.camera],
      // maskTitle: '相机权限说明',
      // maskContent: '便于您使用该功能拍摄照片/图片上传及用于修改头像、图片保存、意见反馈等场景。',
    );

    // 上传设备信息
    if (isUploadDevice) {}
    return hasPermission;
  }

  /// 申请联系人
  Future<bool> requestContacts({
    isUploadDevice = true,
  }) async {
    bool hasPermission = await requestPermissions(
      [Permission.contacts],
      message: permissionMessage[Permission.contacts],
    );

    // 上传设备信息
    if (isUploadDevice) {}
    return hasPermission;
  }

  /// 申请通知
  Future<bool> requestnNotification() async {
    bool hasPermission = await PermissionUtil().requestPermissions(
      [Permission.notification],
      message: permissionMessage[Permission.notification],
      everyAsk: false,
      // maskTitle: '通知权限说明',
      // maskContent: '便于您使用该功能应用后台运行时接收消息通知。',
    );

    return hasPermission;
  }

  /// 应用跟踪
  Future<bool> requestnAppTrackingTransparency() async {
    bool hasPermission = await PermissionUtil().requestPermissions(
      [Permission.notification],
      message: permissionMessage[Permission.appTrackingTransparency],
      everyAsk: false,
      // maskTitle: '通知权限说明',
      // maskContent: '便于您使用该功能应用后台运行时接收消息通知。',
    );

    return hasPermission;
  }

  /// 申请忽略电池能耗(后台运行)
  Future<bool> requestnIgnoreBattery() async {
    bool hasPermission = await PermissionUtil().requestPermissions(
      [Permission.ignoreBatteryOptimizations],
      message: permissionMessage[Permission.ignoreBatteryOptimizations],
      everyAsk: false,
      // maskTitle: '权限说明',
      // maskContent: '便于您使用该功能应用房间畅聊时后台运行保活。',
    );

    return hasPermission;
  }

  /// 申请电话
  Future<bool> requestPhone() async {
    bool hasPermission = await requestPermissions(
      [Permission.phone],
      message: permissionMessage[Permission.phone],
      // maskTitle: '日历权限说明',
      // maskContent: '便于您使用该功能拍摄照片/图片上传及用于修改头像、图片保存、意见反馈等场景。',
    );
    return hasPermission;
  }

  /// 申请电话
  Future<bool> requestSms({
    isUploadDevice = true,
  }) async {
    bool hasPermission = await requestPermissions(
      [Permission.sms],
      message: permissionMessage[Permission.sms],
      // maskTitle: '日历权限说明',
      // maskContent: '便于您使用该功能拍摄照片/图片上传及用于修改头像、图片保存、意见反馈等场景。',
    );
    if (isUploadDevice) {}
    return hasPermission;
  }

  // /// 申请电话
  // Future<bool> requestApps() async {
  //   bool hasPermission = await requestPermissions(
  //     [Permission.manageExternalStorage],
  //     message: _messages[Permission.manageExternalStorage],
  //     // maskTitle: '日历权限说明',
  //     // maskContent: '便于您使用该功能拍摄照片/图片上传及用于修改头像、图片保存、意见反馈等场景。',
  //   );
  //   return hasPermission;
  // }

  //通用单个权限请求
  // Future<bool> requestPermission(Permission permission,
  //     {String message = '您已拒绝使用权限,前往设置打开'}) async {
  //   final status = await permission.status;

  //   if (status.isDenied) {
  //     return status.isGranted;
  //   } else if (status.isPermanentlyDenied || status.isRestricted) {
  //     openAppSettings();
  //   }
  //   return false;
  //   // return _request(permission, message);
  // }

  // Map<Permission, bool> permissionShowMask = {};

  /// 通用多个权限请求
  Future<bool> requestPermissions(
    List<Permission> permissions, {
    String? title,
    String? message,

    /// 是否等待权限设置返回后继续
    bool waitOpenSettingBack = true,

    /// 是否多个权限都通过
    bool bothGranted = true,

    /// 是否每次都询问请求权限
    bool everyAsk = true,

    /// 国内安卓权限提示遮罩
    String? maskTitle,
    String? maskContent,
  }) async {
    Future<bool> permissionStatus() async {
      bool isGranted = false;
      for (var permission in permissions) {
        final status = await permission.status;
        if (!bothGranted && status.isGranted) {
          isGranted = true;
        } else if (!status.isGranted) {
          isGranted = false;
          break;
        }
      }
      return isGranted;
    }

    bool isGranted = await permissionStatus();

    if (isGranted) return isGranted;

    // 发起权限请求
    final saveKey = permissions.map((e) => e.value).join(',');

    // 判断是否第一次请求权限
    final box = GetStorage();
    // 第一次拒绝,不显示打开设置提示
    final firstReqeust = box.read(saveKey) == null;

    // 如果不需要每次请求权限 & 不是第一次请求权限,直接返回权限结果
    if (!everyAsk && !firstReqeust) {
      return isGranted;
    }

    // List<PermissionStatus> items = [];
    // for (var value in permissions) {
    //   // if (firstReqeust) {
    //   items.add(await value.status);
    //   // }
    // }
    // for (var element in items) {
    //   if (element != PermissionStatus.denied) {
    //     items.clear();
    //     break;
    //   }
    // }
    // if (items.isNotEmpty && Platform.isAndroid && maskTitle != null) {
    //   _PermissionTosatManager.instance
    //       .showPermissionTosat(permissions.first, maskTitle, maskContent!);
    //   permissionShowMask[permissions.first] = true;
    // }

    // 权限请求
    final status = await _request(permissions, bothGranted: bothGranted);

    // if (permissionShowMask[permissions.first] == true) {
    //   _PermissionTosatManager.instance.hidePermissionTosat(permissions.first);
    // }
    // 记录权限请求缓存
    if (firstReqeust) {
      box.write(saveKey, saveKey);
      // return status.isGranted;
    }

    // 如果是通过,返回请求结果
    if (status.isGranted) {
      return status.isGranted;
    }

    // 第N请求权限失败,默认打开消息提示框
    if (waitOpenSettingBack) {
      await showPermissionAlert(title: title, message: message);

      // 关闭弹窗后，重新查一次
      return await permissionStatus();
    }

    // 提示打开设置
    // commonDialog2(
    //   context: Routers.navigatorKey.currentContext!,
    //   dialog: CommonDialog(
    //       title: title ?? '权限申请',
    //       message:
    //           message ?? _messages[permissions.first] ?? _messages['default'],
    //       confirmClick: () async {
    //         Routers.goBack(Routers.navigatorKey.currentContext!);
    //         await openAppSettings();
    //       },
    //       cancelClick: () {
    //         Routers.goBack(Routers.navigatorKey.currentContext!);
    //       }),
    // );
    showPermissionAlert(title: title, message: message);

    return status.isGranted;
  }

  //通用获取权限状态
  Future<bool> requestStatus(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// 组合权限判断是否通过
  Future<PermissionStatus> _request(
    List<Permission> items, {
    /// 是否多个权限都通过
    bool bothGranted = true,
  }) async {
    Map<Permission, PermissionStatus> res = await items.request();
    PermissionStatus status = PermissionStatus.granted;
    res.forEach((key, value) {
      if (!bothGranted && value.isGranted) {
        status = value;
        return;
      } else if (!value.isGranted) {
        status = value;
        return;
      }
    });

    return status;
  }

  showPermissionAlert({
    String? title,
    String? message,
  }) async {
    return Get.dialog(
      AlertContentView(
        // title: "Warnning",
        content: message ?? 'Language.permission',
        onRight: () async {
          // await: 是否成功打开设置
          await openAppSettings();
        },
      ),
      useSafeArea: false,
      barrierColor: const Color(0x43010101),
    );
  }
}

final permissionMessage = {
  // 'default': '您已拒绝访问，是否要前往设置打开？',
  // Permission.storage: '您拒绝了存储权限，是否要前往设置打开？',
  // Permission.camera: '您拒绝了相机权限，是否要前往设置打开？',
  // Permission.location: '您拒绝了位置权限，是否要前往设置打开？',
  // Permission.microphone: '您拒绝了麦克风权限，是否要前往设置打开？',
  // Permission.contacts: '您拒绝了通讯录访问,您要前往设置吗？',
  // Permission.phone: '您拒绝了手机权限，是否要前往设置打开？',
  // Permission.notification: '您拒绝了通知权限，是否要前往设置打开？',
  // Permission.photos: '您拒绝了相册权限，是否要前往设置打开？',
  // Permission.ignoreBatteryOptimizations: '您拒绝了后台权限，是否要前往设置打开？',
};

class _PermissionTosatManager {
  static final _instance = _PermissionTosatManager._();

  static _PermissionTosatManager get instance => _instance;

  _PermissionTosatManager._();

  /// 记录对应关系
  Map<Permission, OverlayEntry?> overlayEntrys = {};

  /// 显示提示框
  void showPermissionTosat(
      Permission permission, String title, String content) {
    if (overlayEntrys[permission] != null) {
      hidePermissionTosat(permission);
    }
    final entry =
        OverlayEntry(builder: (context) => _PermissionTosat(title, content));
    overlayEntrys[permission] = entry;
    Overlay.of(Get.context!).insert(entry);
  }

  /// 隐藏提示框
  void hidePermissionTosat(Permission permission) {
    final entry = overlayEntrys[permission];
    if (entry != null) {
      entry.remove();
      overlayEntrys.remove(permission);
    }
  }
}

class _PermissionTosat extends StatelessWidget {
  const _PermissionTosat(this.title, this.content, {super.key});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(
            maxWidth: 260,
          ),
          // margin: EdgeInsets.symmetric(horizontal: 58),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: '#FF000000'.toColor.font_14.bold),
              const SizedBox(height: 5),
              Text(content, style: '#FF6F6F6F'.toColor.font_13),
            ],
          ),
        ),
      ),
    );
  }
}
