import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tabs_template/network/req_interceptor.dart';
import 'package:tabs_template/network/resp_interceptor.dart';

import 'package:tabs_template/widgets/common/toast.dart';
import 'package:tabs_template/network/api_client.dart';

/// 统一请求入口与错误展示。
void formatError(e) {
  // logger.d(e.toString());
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
        RequestDataInterceptor(),
        ResponseDataInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      ]),
    baseUrl: 'https://api.apiopen.top/api',
  );
}
