import 'dart:convert';

import 'package:dio/dio.dart';

import '../services/user.dart';

/// 请求拦截相关的处理
class NetInterceptor extends Interceptor {
  NetInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = UserService.to.token.token;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = token;
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Map dataMap;
    if (response.data is Map) {
      dataMap = response.data;
    } else if (response.data is String) {
      dataMap = jsonDecode(response.data);
    } else {
      dataMap = {'code': 200, 'data': response.data, 'message': 'success'};
    }

    if (dataMap['code'] != 200) {
      if (dataMap['code'] == 402 || dataMap['code'] == 401) {
        // _ref.read(eventBusProvider).fire(AppNeedToLogin());
      }
      handler.reject(
        DioError(
          requestOptions: response.requestOptions,
          error: dataMap['message'],
        ),
        true,
      );
      return;
    }
    response.data = dataMap['result'];
    handler.next(response);
  }
}
