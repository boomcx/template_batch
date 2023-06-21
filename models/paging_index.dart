import 'package:freezed_annotation/freezed_annotation.dart';
part 'paging_index.freezed.dart';
part 'paging_index.g.dart';

@Freezed(genericArgumentFactories: true)
class PagingIndex<T> with _$PagingIndex {
  const factory PagingIndex({
    @Default(0) int total,
    @Default([]) List<T> list,
  }) = _PagingIndex;

  factory PagingIndex.fromJson(
          Map<String, Object?> json, T Function(dynamic json) fromJsonT) =>
      _$PagingIndexFromJson(json, fromJsonT);
}
