// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppToken _$AppTokenFromJson(Map<String, dynamic> json) => AppToken(
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$AppTokenToJson(AppToken instance) => <String, dynamic>{
      'token': instance.token,
    };

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['result'],
    );

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.data,
    };
