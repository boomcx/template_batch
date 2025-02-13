import 'package:dio/dio.dart';

import '../models/app_token.dart';
import '../widgets/common/toast.dart';

/// 请求结果拦截相关的处理
class ResponseDataInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.headers['hideLoading'] != false) {
      Toast.hideLoading();
    }

    // 网络畅通
    // AppService.to.connectivity.value = true;

    // 服务器返回的数据
    BaseResponse resp = BaseResponse.fromJson(response.data);

    // 请求成功
    if (resp.code == 200) {
      response.data = resp.data;
      handler.next(response);
      return;
    }

    // 通用异常处理
    if (resp.code == 401) {
      // UserService.to.logout();
      return;
    }

    // 将错误的返回数据，直接抛出到请求失败中处理
    // 在接口调用的位置，使用 [try...catch] 进行错误捕获
    throw DioException(
      requestOptions: response.requestOptions,
      error: DioExceptionType.badResponse,
      // 这里debug模式输出完整的错误日志方便定位问题，线上环境直接输出错误信息
      // message: kReleaseMode ? resp.message : resp.toJson().toString(),
      message: resp.message,
    );
    // handler.reject(
    //   DioException(
    //     requestOptions: response.requestOptions,
    //     error: DioExceptionType.badResponse,
    //     message: resp.message,
    //   ),
    //   false,
    // );
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    // final path = '${err.requestOptions.uri}';
    hideLoading();

    // final code = err.response?.data['succession'];

    // 网络异常
    // InternetConnection().hasInternetAccess.then((value) {
    //   AppService.to.connectivity.value = value;
    // });

    // 显示错误信息
    if (err.message?.isNotEmpty == true &&
        err.type != DioExceptionType.connectionTimeout) {
      Toast.message(err.message!);
    }
  }
}
