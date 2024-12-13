import 'package:dio/dio.dart';

/// 统一请求处理
class RequestDataInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['Content-Type'] = 'application/octet-stream';
    // 公共参数
    options.headers['token'] = 'token';

    handler.next(options);
  }
}
