import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_token.freezed.dart';
part 'app_token.g.dart';

@freezed
class AppToken with _$AppToken {
  const factory AppToken({
    @Default('') String token,
  }) = _AppToken;
  factory AppToken.fromJson(Map<String, Object?> json) =>
      _$AppTokenFromJson(json);
}

/// 对照服务器返回数据进行修改
@freezed
class BaseResponse with _$BaseResponse {
  const factory BaseResponse({
    @JsonKey(name: 'code') int? code,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'result') dynamic data,
  }) = _BaseResponse;

  factory BaseResponse.fromJson(Map<String, Object?> json) =>
      _$BaseResponseFromJson(json);
}
