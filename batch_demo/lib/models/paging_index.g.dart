// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paging_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PagingIndex<T> _$$_PagingIndexFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_PagingIndex<T>(
      total: json['total'] as int? ?? 0,
      list:
          (json['list'] as List<dynamic>?)?.map(fromJsonT).toList() ?? const [],
    );

Map<String, dynamic> _$$_PagingIndexToJson<T>(
  _$_PagingIndex<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'list': instance.list.map(toJsonT).toList(),
    };
