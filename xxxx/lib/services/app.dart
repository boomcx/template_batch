import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

/// `event_bus`通知挂载
class AppNeedToLogin {}

class AppService extends GetxService {
  static AppService get to => Get.find();

  /// 全局通知
  static EventBus get bus => to._bus;
  final _bus = EventBus();
}
