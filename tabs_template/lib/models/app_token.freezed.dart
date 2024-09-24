// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppToken _$AppTokenFromJson(Map<String, dynamic> json) {
  return _AppToken.fromJson(json);
}

/// @nodoc
mixin _$AppToken {
  String get token => throw _privateConstructorUsedError;

  /// Serializes this AppToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppTokenCopyWith<AppToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppTokenCopyWith<$Res> {
  factory $AppTokenCopyWith(AppToken value, $Res Function(AppToken) then) =
      _$AppTokenCopyWithImpl<$Res, AppToken>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$AppTokenCopyWithImpl<$Res, $Val extends AppToken>
    implements $AppTokenCopyWith<$Res> {
  _$AppTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppTokenImplCopyWith<$Res>
    implements $AppTokenCopyWith<$Res> {
  factory _$$AppTokenImplCopyWith(
          _$AppTokenImpl value, $Res Function(_$AppTokenImpl) then) =
      __$$AppTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$AppTokenImplCopyWithImpl<$Res>
    extends _$AppTokenCopyWithImpl<$Res, _$AppTokenImpl>
    implements _$$AppTokenImplCopyWith<$Res> {
  __$$AppTokenImplCopyWithImpl(
      _$AppTokenImpl _value, $Res Function(_$AppTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$AppTokenImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppTokenImpl implements _AppToken {
  const _$AppTokenImpl({this.token = ''});

  factory _$AppTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppTokenImplFromJson(json);

  @override
  @JsonKey()
  final String token;

  @override
  String toString() {
    return 'AppToken(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppTokenImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  /// Create a copy of AppToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppTokenImplCopyWith<_$AppTokenImpl> get copyWith =>
      __$$AppTokenImplCopyWithImpl<_$AppTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppTokenImplToJson(
      this,
    );
  }
}

abstract class _AppToken implements AppToken {
  const factory _AppToken({final String token}) = _$AppTokenImpl;

  factory _AppToken.fromJson(Map<String, dynamic> json) =
      _$AppTokenImpl.fromJson;

  @override
  String get token;

  /// Create a copy of AppToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppTokenImplCopyWith<_$AppTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return _BaseResponse.fromJson(json);
}

/// @nodoc
mixin _$BaseResponse {
  @JsonKey(name: 'code')
  int? get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'result')
  dynamic get data => throw _privateConstructorUsedError;

  /// Serializes this BaseResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BaseResponseCopyWith<BaseResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseResponseCopyWith<$Res> {
  factory $BaseResponseCopyWith(
          BaseResponse value, $Res Function(BaseResponse) then) =
      _$BaseResponseCopyWithImpl<$Res, BaseResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'code') int? code,
      @JsonKey(name: 'message') String? message,
      @JsonKey(name: 'result') dynamic data});
}

/// @nodoc
class _$BaseResponseCopyWithImpl<$Res, $Val extends BaseResponse>
    implements $BaseResponseCopyWith<$Res> {
  _$BaseResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BaseResponseImplCopyWith<$Res>
    implements $BaseResponseCopyWith<$Res> {
  factory _$$BaseResponseImplCopyWith(
          _$BaseResponseImpl value, $Res Function(_$BaseResponseImpl) then) =
      __$$BaseResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'code') int? code,
      @JsonKey(name: 'message') String? message,
      @JsonKey(name: 'result') dynamic data});
}

/// @nodoc
class __$$BaseResponseImplCopyWithImpl<$Res>
    extends _$BaseResponseCopyWithImpl<$Res, _$BaseResponseImpl>
    implements _$$BaseResponseImplCopyWith<$Res> {
  __$$BaseResponseImplCopyWithImpl(
      _$BaseResponseImpl _value, $Res Function(_$BaseResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? data = freezed,
  }) {
    return _then(_$BaseResponseImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BaseResponseImpl implements _BaseResponse {
  const _$BaseResponseImpl(
      {@JsonKey(name: 'code') this.code,
      @JsonKey(name: 'message') this.message,
      @JsonKey(name: 'result') this.data});

  factory _$BaseResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BaseResponseImplFromJson(json);

  @override
  @JsonKey(name: 'code')
  final int? code;
  @override
  @JsonKey(name: 'message')
  final String? message;
  @override
  @JsonKey(name: 'result')
  final dynamic data;

  @override
  String toString() {
    return 'BaseResponse(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BaseResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, message, const DeepCollectionEquality().hash(data));

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BaseResponseImplCopyWith<_$BaseResponseImpl> get copyWith =>
      __$$BaseResponseImplCopyWithImpl<_$BaseResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BaseResponseImplToJson(
      this,
    );
  }
}

abstract class _BaseResponse implements BaseResponse {
  const factory _BaseResponse(
      {@JsonKey(name: 'code') final int? code,
      @JsonKey(name: 'message') final String? message,
      @JsonKey(name: 'result') final dynamic data}) = _$BaseResponseImpl;

  factory _BaseResponse.fromJson(Map<String, dynamic> json) =
      _$BaseResponseImpl.fromJson;

  @override
  @JsonKey(name: 'code')
  int? get code;
  @override
  @JsonKey(name: 'message')
  String? get message;
  @override
  @JsonKey(name: 'result')
  dynamic get data;

  /// Create a copy of BaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BaseResponseImplCopyWith<_$BaseResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
