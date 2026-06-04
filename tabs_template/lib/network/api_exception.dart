import 'package:dio/dio.dart';

/// 业务错误载体，保留 code/message/data 供调用方读取。
class ApiException {
  const ApiException({
    this.code,
    required this.message,
    this.data,
    this.response,
  });

  /// 服务器返回的业务码。
  final int? code;

  /// 可直接展示或记录的错误文案。
  final String message;

  /// 服务器返回的业务数据。
  final dynamic data;

  /// 原始响应，便于排查问题。
  final Response? response;
}
