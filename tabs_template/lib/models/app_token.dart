import 'package:json_annotation/json_annotation.dart';

part 'app_token.g.dart';

/// 本地鉴权信息。
@JsonSerializable()
class AppToken {
  const AppToken({
    this.token = '',
  });
  final String token;

  factory AppToken.fromJson(Map<String, dynamic> json) =>
      _$AppTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AppTokenToJson(this);
}

/// 通用接口响应体。
@JsonSerializable()
class BaseResponse {
  const BaseResponse({
    @JsonKey(name: 'code') this.code,
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'result') this.data,
  });

  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'result')
  final dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
