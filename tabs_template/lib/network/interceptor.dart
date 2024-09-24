import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../app.dart';
import '../models/app_token.dart';
import '../service.dart';

/// 请求拦截相关的处理
class NetInterceptor extends Interceptor {
  NetInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 公共参数
    options.headers['xxxxx'] = 'xxxxx';

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 服务器返回的数据
    BaseResponse resp = BaseResponse.fromJson(response.data);

    // 请求成功，需要和自己服务器的code保持一致
    if (resp.code == 200) {
      response.data = resp.data;
      handler.next(response);
      return;
    }

    // 通用异常处理
    if (resp.code == 401) {
      // AppService.bus.fire(AppNeedToLogin());
      UserService.to.logout();
      return;
    }

    // 将错误的返回数据，直接抛出到请求失败中处理
    // 在接口调用的位置，使用 [try...catch] 进行错误捕获
    throw DioException(
      requestOptions: response.requestOptions,
      error: DioExceptionType.badResponse,
      // 这里debug模式输出完整的错误日志方便定位问题，线上环境直接输出错误信息
      message: kReleaseMode ? resp.message : resp.toJson().toString(),
    );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    // final path = '${err.requestOptions.uri}';
    // 显示错误信息
    Toast.message(err.message ?? 'request error');
  }
}
