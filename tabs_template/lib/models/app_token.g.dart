// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppTokenImpl _$$AppTokenImplFromJson(Map<String, dynamic> json) =>
    _$AppTokenImpl(
      token: json['token'] as String? ?? '',
    );

Map<String, dynamic> _$$AppTokenImplToJson(_$AppTokenImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
    };

_$BaseResponseImpl _$$BaseResponseImplFromJson(Map<String, dynamic> json) =>
    _$BaseResponseImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['result'],
    );

Map<String, dynamic> _$$BaseResponseImplToJson(_$BaseResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.data,
    };
