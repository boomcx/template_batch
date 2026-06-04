import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:tabs_template/network/api_exception.dart';
import 'package:tabs_template/models/app_token.dart';
import 'package:tabs_template/widgets/common/toast.dart';

/// 统一处理接口结果。
///
/// - `code == 200` 时返回 `result`。
/// - `code != 200` 时抛出 `ApiException`。
/// - 请求失败时统一记录并弹框。
class ResponseDataInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _hideLoadingIfNeeded(response.requestOptions);

    late BaseResponse resp;
    try {
      resp = _parseBaseResponse(response);
    } on DioException catch (err) {
      _handleException(err);
      handler.reject(err);
      return;
    }

    if (resp.code == 200) {
      response.data = resp.data;
      handler.next(response);
      return;
    }

    final apiException = ApiException(
      code: resp.code,
      message: _errorMessage(resp.message),
      data: resp.data,
      response: response,
    );
    final exception = DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
      message: apiException.message,
      error: apiException,
    );
    _handleException(exception);
    handler.reject(exception);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _hideLoadingIfNeeded(err.requestOptions);
    _handleException(err);
    handler.reject(err);
  }

  /// 解析服务器统一响应结构。
  BaseResponse _parseBaseResponse(Response response) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return BaseResponse.fromJson(data);
    }
    if (data is Map) {
      return BaseResponse.fromJson(Map<String, dynamic>.from(data));
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
      message: '响应数据格式异常',
      error: data,
    );
  }

  /// 按请求配置决定是否关闭 loading。
  void _hideLoadingIfNeeded(RequestOptions options) {
    if (options.headers['hideLoading'] != false) {
      Toast.hideLoading();
    }
  }

  /// 统一记录并弹出错误信息。
  void _handleException(DioException err) {
    final message = _extractMessage(err);
    log(
      message,
      name: 'ResponseDataInterceptor',
      error: err,
      stackTrace: err.stackTrace,
    );
    Toast.showError(message);
  }

  /// 优先读取业务异常文案。
  String _extractMessage(DioException err) {
    final error = err.error;
    if (error is ApiException) {
      return _errorMessage(error.message);
    }
    return _errorMessage(err.message);
  }

  String _errorMessage(String? message) {
    if (message?.trim().isNotEmpty == true) {
      return message!.trim();
    }
    return '请求异常';
  }
}
