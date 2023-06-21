// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paging_index.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PagingIndex<T> _$PagingIndexFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _PagingIndex<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$PagingIndex<T> {
  int get total => throw _privateConstructorUsedError;
  List<T> get list => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PagingIndexCopyWith<T, PagingIndex<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagingIndexCopyWith<T, $Res> {
  factory $PagingIndexCopyWith(
          PagingIndex<T> value, $Res Function(PagingIndex<T>) then) =
      _$PagingIndexCopyWithImpl<T, $Res, PagingIndex<T>>;
  @useResult
  $Res call({int total, List<T> list});
}

/// @nodoc
class _$PagingIndexCopyWithImpl<T, $Res, $Val extends PagingIndex<T>>
    implements $PagingIndexCopyWith<T, $Res> {
  _$PagingIndexCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? list = null,
  }) {
    return _then(_value.copyWith(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PagingIndexCopyWith<T, $Res>
    implements $PagingIndexCopyWith<T, $Res> {
  factory _$$_PagingIndexCopyWith(
          _$_PagingIndex<T> value, $Res Function(_$_PagingIndex<T>) then) =
      __$$_PagingIndexCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int total, List<T> list});
}

/// @nodoc
class __$$_PagingIndexCopyWithImpl<T, $Res>
    extends _$PagingIndexCopyWithImpl<T, $Res, _$_PagingIndex<T>>
    implements _$$_PagingIndexCopyWith<T, $Res> {
  __$$_PagingIndexCopyWithImpl(
      _$_PagingIndex<T> _value, $Res Function(_$_PagingIndex<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? total = null,
    Object? list = null,
  }) {
    return _then(_$_PagingIndex<T>(
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$_PagingIndex<T> implements _PagingIndex<T> {
  const _$_PagingIndex({this.total = 0, final List<T> list = const []})
      : _list = list;

  factory _$_PagingIndex.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$_PagingIndexFromJson(json, fromJsonT);

  @override
  @JsonKey()
  final int total;
  final List<T> _list;
  @override
  @JsonKey()
  List<T> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  String toString() {
    return 'PagingIndex<$T>(total: $total, list: $list)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PagingIndex<T> &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._list, _list));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, total, const DeepCollectionEquality().hash(_list));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PagingIndexCopyWith<T, _$_PagingIndex<T>> get copyWith =>
      __$$_PagingIndexCopyWithImpl<T, _$_PagingIndex<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$_PagingIndexToJson<T>(this, toJsonT);
  }
}

abstract class _PagingIndex<T> implements PagingIndex<T> {
  const factory _PagingIndex({final int total, final List<T> list}) =
      _$_PagingIndex<T>;

  factory _PagingIndex.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$_PagingIndex<T>.fromJson;

  @override
  int get total;
  @override
  List<T> get list;
  @override
  @JsonKey(ignore: true)
  _$$_PagingIndexCopyWith<T, _$_PagingIndex<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
