// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class PagingMixinController<T> extends ValueNotifier<PagingMixinData<T>> {
  PagingMixinController(super.value);

  dynamic get error => value.error;
  List<T> get items => value.items;
  int get itemCount => items.length;
}

class PagingMixinData<T> {
  // 列表数据
  final List<T> items;

  /// 错误信息
  final dynamic error;

  /// 首次加载是否为空
  bool isStartEmpty;

  PagingMixinData({
    required this.items,
    this.error,
    this.isStartEmpty = false,
  });

  PagingMixinData<T> copyWith({
    List<T>? items,
    dynamic error,
    bool? isStartEmpty,
  }) {
    return PagingMixinData<T>(
      items: items ?? this.items,
      error: error ?? this.error,
      isStartEmpty: isStartEmpty ?? this.isStartEmpty,
    );
  }

  @override
  bool operator ==(covariant PagingMixinData<T> other) {
    if (identical(this, other)) return true;

    return listEquals(other.items, items) &&
        other.error == error &&
        other.isStartEmpty == isStartEmpty;
  }

  @override
  int get hashCode => items.hashCode ^ error.hashCode ^ isStartEmpty.hashCode;
}
