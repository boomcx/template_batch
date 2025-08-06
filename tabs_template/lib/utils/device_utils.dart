// import 'dart:io';
// import 'package:advertising_id/advertising_id.dart';
// import 'package:battery_plus/battery_plus.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
// import 'package:memory_info/memory_info.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:storage_info/storage_info.dart';

// class DeviceInfoService {
//   final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
//   final Battery _battery = Battery();
//   final Connectivity _connectivity = Connectivity();
//   final NetworkInfo _networkInfo = NetworkInfo();
//   final MemoryInfoPlugin _memoryInfo = MemoryInfoPlugin();
//   final _storageInfoPlugin = StorageInfo();

//   // 获取所有设备信息
//   Future<Map<String, dynamic>> getAllDeviceInfo() async {
//     final data = {
//       "speople": await _getStorageAndMemoryInfo(),
//       "takeanother": await _getBatteryInfo(),
//       "farasked": await _getSystemInfo(),
//       "impulsively": await _getDeviceStatus(),
//       "catching": await _getEnvironmentInfo(),
//       "thanever": await _getWifiInfo(),
//     };
//     print(data);
//     return data;
//   }

//   // 1. 获取存储和内存信息
//   Future<Map<String, String>> _getStorageAndMemoryInfo() async {
//     // 存储信息
//     // final storageInfo = await _storageInfoPlugin.getStorageTotalSpace();
//     final totalStorage = await _storageInfoPlugin.getStorageTotalSpace(); // 总存储
//     final freeStorage = await _storageInfoPlugin.getStorageFreeSpace(); // 可用存储

//     // 内存信息
//     final memoryInfo = await _memoryInfo.memoryInfo;
//     final totalMemory = memoryInfo.totalMem; // 总内存
//     final freeMemory = memoryInfo.freeMem; // 可用内存

//     return {
//       "industriously": freeStorage.toString(), // 可用存储大小
//       "madeup": totalStorage.toString(), // 总存储大小
//       "wasbetty": totalMemory.toString(), // 总内存大小
//       "particular": freeMemory.toString() // 内存可用大小
//     };
//   }

//   // 2. 获取电池信息
//   Future<Map<String, dynamic>> _getBatteryInfo() async {
//     int batteryLevel = await _battery.batteryLevel;
//     bool isCharging = (await _battery.batteryState) == BatteryState.charging;

//     return {
//       "poeplewere": batteryLevel, // 剩余电量（百分比）
//       "whose": isCharging ? 1 : 0 // 是否正在充电 0、1
//     };
//   }

//   // 3. 获取系统信息
//   Future<Map<String, String>> _getSystemInfo() async {
//     String systemVersion = "";
//     String brand = "";
//     String model = "";

//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
//       systemVersion = androidInfo.version.release ?? "";
//       brand = androidInfo.brand ?? "";
//       model = androidInfo.model ?? "";
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
//       systemVersion = iosInfo.systemVersion ?? "";
//       brand = "Apple";
//       model = iosInfo.utsname.machine ?? ""; // 原始设备型号
//     }

//     return {
//       "anotherword": systemVersion, // 系统版本
//       "myparents": brand, // 设备品牌
//       "hailed": model // 原始设备型号
//     };
//   }

//   // 4. 获取设备状态（模拟器、越狱）
//   Future<Map<String, int>> _getDeviceStatus() async {
//     bool isEmulator = false;
//     bool isJailbroken = false;

//     // 检测是否为模拟器
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
//       isEmulator = androidInfo.isPhysicalDevice != true;
//     } else if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
//       isEmulator = iosInfo.isPhysicalDevice != true;
//     }

//     // 检测是否越狱/root
//     isJailbroken = await JailbreakRootDetection.instance.isJailBroken;

//     return {
//       "struckby": isEmulator ? 1 : 0, // 是否为模拟器
//       "trudging": isJailbroken ? 1 : 0 // 是否越狱
//     };
//   }

//   // 5. 获取环境信息
//   Future<Map<String, String>> _getEnvironmentInfo() async {
//     // 时区
//     String timeZone = await FlutterNativeTimezone.getLocalTimezone();

//     // 语言
//     String language = Platform.localeName.split('_').first;

//     // 网络类型
//     ConnectivityResult connectivityResult =
//         (await _connectivity.checkConnectivity()).first;
//     String networkType = _getNetworkTypeString(connectivityResult);

//     // IDFV (应用开发商标识符)
//     String idfv = "";
//     if (Platform.isIOS) {
//       IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
//       idfv = iosInfo.identifierForVendor ?? "";
//     } else if (Platform.isAndroid) {
//       // Android 没有直接对应的IDFV，可用UUID替代或使用其他标识符
//       // AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
//       // idfv = androidInfo.androidId ?? "";
//     }

//     // IDFA (广告标识符)
//     String idfa = "";
//     try {
//       idfa = await AdvertisingId.id() ?? "";
//     } catch (e) {
//       print("获取IDFA失败: $e");
//     }

//     return {
//       "parentswere": timeZone, // 时区的 ID
//       "welcome": idfv, // idfv
//       "fo": language, // 语言
//       "spirits": networkType, // 网络类型
//       "shrieks": idfa // idfa
//     };
//   }

//   // 6. 获取WiFi信息
//   Future<Map<String, dynamic>> _getWifiInfo() async {
//     try {
//       String? wifiName = await _networkInfo.getWifiName();
//       String? wifiBSSID = await _networkInfo.getWifiBSSID();

//       if (wifiName != null && wifiBSSID != null) {
//         return {
//           "sober": {
//             "sing": wifiBSSID, // mac地址
//             "joking": wifiName // WiFi名称
//           }
//         };
//       }
//     } catch (e) {
//       print("获取WiFi信息失败: $e");
//     }

//     return {}; // 没有WiFi连接时返回空对象
//   }

//   // 转换网络类型为字符串
//   String _getNetworkTypeString(ConnectivityResult result) {
//     switch (result) {
//       case ConnectivityResult.wifi:
//         return "WIFI";
//       case ConnectivityResult.mobile:
//         // 这里可以进一步判断是2G/3G/4G/5G，但需要额外插件
//         return "MOBILE";
//       default:
//         return "OTHER";
//     }
//   }
// }

// // 使用示例
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   DeviceInfoService deviceInfoService = DeviceInfoService();
//   Map<String, dynamic> deviceInfo = await deviceInfoService.getAllDeviceInfo();

//   print(deviceInfo);
// }
