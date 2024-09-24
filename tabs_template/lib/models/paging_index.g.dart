// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PagingIndexImpl<T> _$$PagingIndexImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$PagingIndexImpl<T>(
      total: (json['total'] as num?)?.toInt() ?? 0,
      list:
          (json['list'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
    );

Map<String, dynamic> _$$PagingIndexImplToJson<T>(
  _$PagingIndexImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list.map(toJsonT).toList(),
    };
