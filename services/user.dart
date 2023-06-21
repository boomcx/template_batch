import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:template_getx/app.dart';
import '../models.dart';

const _kAppToken = 'k_app_token';
const _kUser = 'k_user';

/// 用户相关的全局处理
class UserService extends GetxService {
  static UserService get to => Get.find();
  final box = Hive.box('app');

  /// 用户是否登录
  bool get isLogined => token.token.isNotEmpty;

  /// 身份鉴权
  var token = const AppToken();

  /// 用户信息
  var user = const User().obs;

  @override
  void onReady() {
    final tokenStr = box.get(_kAppToken, defaultValue: '') as String;
    if (tokenStr.isNotEmpty) {
      // 获取本地鉴权信息
      token = AppToken.fromJson(jsonDecode(tokenStr));
      // 获取用户信息
      final userStr = box.get(_kUser, defaultValue: '') as String;
      if (userStr.isNotEmpty) {
        user.value = User.fromJson(jsonDecode(userStr));
      }
    }

    super.onReady();
  }

  updateUser() async {
    NetRepository.client.logout();
  }

  login() {}

  logout() {
    removeUser();
    // others
  }

  removeUser() {
    // 清除现有信息
    token = const AppToken();
    user.value = const User();

    // 清除本地
    box.clear();
  }
}
