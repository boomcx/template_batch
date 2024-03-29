import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app.dart';
import '../service.dart';

/// 请求拦截相关的处理
class NetInterceptor extends Interceptor {
  NetInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Basic c3dvcmQ6c3dvcmRfc2VjcmV0';
    options.headers['Tenant-Id'] = '';

    final token = UserService.to.token.token;
    if (token.isNotEmpty) {
      options.headers['Blade-Auth'] = token;
    }

    /// 平台类型: 1 安卓;2 苹果
    options.headers['platformType'] = Platform.isIOS ? '2' : '1';
    options.headers['device'] = AppService.to.device.identifier;

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _printResponse(response);
    Map dataMap;
    if (response.data is Map) {
      // 解决没有code返回的情况
      if (response.data['success'] == 'true' && response.data['code'] == null) {
        response.data['code'] == 200;
      }
      dataMap = response.data;
    } else if (response.data is String) {
      dataMap = jsonDecode(response.data);
    } else {
      dataMap = {'code': 200, 'data': response.data, 'msg': 'success'};
    }

    /// 优先处理请求成功
    if (dataMap['code'] == 200 || '${dataMap['success']}' == 'true') {
      /// 请求成功的异常xinxi
      if (dataMap['data'] is Map && dataMap['data']['error_code'] != null) {
        final message = dataMap['data']['error_description'] ?? '返回结果错误';
        handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            error: message,
          ),
          true,
        );
        Toast.hideLoading();
        Toast.message(message);
        return;
      }
      if (dataMap['code'] == 200) {
        response.data = dataMap['data'] ?? {};
      } else {
        // 状态码为其他值，且需要返回数据
        response.data = dataMap;
      }
      handler.next(response);
      return;
    }

    // 状态码为其他值，且需要返回数据
    final specialCode = [260, 261, 262].contains(dataMap['code']);
    // final specialUrl = response.realUri.path.contains('/articleDetail');

    if (specialCode) {
      // 状态码为其他值，且需要返回数据
      response.data = dataMap;
      handler.next(response);
      return;
    }

    // 通用异常处理
    if (dataMap['code'] == 401) {
      // AppService.bus.fire(AppNeedToLogin());
      UserService.to.logout();
      return;
    }

    // 错误处理
    handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        error: dataMap['msg'],
      ),
      true,
    );
    Toast.hideLoading();
    Toast.message(
      dataMap['msg'],
      onClose: () {
        /// 用户被删除
        if (dataMap['code'] == 499) {
          Get.back();
        }
      },
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    debugPrint('------------ ${err.response}');
    final path = '${err.requestOptions.uri}';

    // 如果获取用户信息错误，则跳转到登录
    if (path.contains('/user/currentUserDetails')) {
      showMessage(
        '登录已过期，请重新登录',
      );
      UserService.to.logout();
      // } else {
      //   showMessage('请求异常，请稍候重试');
    }
  }
}

void _printResponse(Response response) {
  // final path = response.requestOptions.uri.path;
  // final tag = path.split('?').first;
  log('''
------------------------ 输出响应数据 - 开始 ------------------------
url = ${response.requestOptions.uri}
method = ${response.requestOptions.method}
headers = ${response.requestOptions.headers}
queryParameters = ${response.requestOptions.queryParameters}
requestData = ${response.requestOptions.data}
${response.toString()},
------------------------ 输出响应数据 - 结束 ------------------------
''');
}
