import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models.dart';
import '../network/repository.dart';

const _kAppToken = 'k_app_token';
const _kUser = 'k_user';

/// 用户相关的全局处理
class UserService extends GetxService {
  static UserService get to => Get.find();
  final box = GetStorage();

  /// 用户是否登录
  bool get isLogined => token.token.isNotEmpty;

  /// 身份鉴权
  var token = const AppToken();

  /// 用户信息
  var user = const User().obs;

  @override
  void onReady() {
    final tokenStr = box.read(_kAppToken) ?? '';
    if (tokenStr.isNotEmpty) {
      // 获取本地鉴权信息
      token = AppToken.fromJson(jsonDecode(tokenStr));
      // 获取用户信息
      final userStr = box.read(_kUser) ?? '';
      if (userStr.isNotEmpty) {
        user.value = User.fromJson(jsonDecode(userStr));
      }
    }

    super.onReady();
  }

  updateUser() async {
    NetRepository.client.logout();
  }

  login() {
    token = const AppToken(token: 'test_token');
  }

  logout() {
    removeUser();
    // others
  }

  removeUser() {
    // 清除现有信息
    token = const AppToken();
    user.value = const User();

    // 清除本地，针对删除
    box.read(_kAppToken);
    box.read(_kUser);
  }
}
