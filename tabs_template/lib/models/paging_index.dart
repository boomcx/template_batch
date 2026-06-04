import 'package:json_annotation/json_annotation.dart';

part 'paging_index.g.dart';

/// 泛型分页响应。
@JsonSerializable(genericArgumentFactories: true)
class PagingIndex<T> {
  const PagingIndex({
    this.total = 0,
    this.list = const [],
  });
  final int total;
  final List<T> list;

  factory PagingIndex.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PagingIndexFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PagingIndexToJson(this, toJsonT);
}
