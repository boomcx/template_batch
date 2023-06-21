import 'package:dio/dio.dart';
import 'package:template_getx/app.dart';

import 'api_client.dart';
import 'interceptor.dart';

/// 统一处理错误信息
void formatError(e) {
  logger.d(e.toString());
  if (e is Response) {
    Toast.showError(e.statusMessage ?? '');
    return;
  }
  Toast.showError('请求异常');
}

class NetRepository {
  /// 请求体 (如果域名不一致可以创建多个请求体进行区分)
  static ApiClient client = ApiClient(
    Dio(BaseOptions())
      ..interceptors.addAll([
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
        NetInterceptor(),
      ]),
    baseUrl: _devDomain.host,
  );
}

final _devDomain = AppDomain(
  host: 'https://api.apiopen.top/api',
  pcHost: 'http://www.xxx.com ',
);

class AppDomain {
  /// 接口域名
  final String host;

  /// 电脑端地址
  final String pcHost;

  /// final String host1;
  /// final String host2;
  /// ...

  AppDomain({
    required this.host,
    required this.pcHost,
  });
}
