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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppToken _$AppTokenFromJson(Map<String, dynamic> json) {
  return _AppToken.fromJson(json);
}

/// @nodoc
mixin _$AppToken {
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_AppTokenCopyWith<$Res> implements $AppTokenCopyWith<$Res> {
  factory _$$_AppTokenCopyWith(
          _$_AppToken value, $Res Function(_$_AppToken) then) =
      __$$_AppTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$_AppTokenCopyWithImpl<$Res>
    extends _$AppTokenCopyWithImpl<$Res, _$_AppToken>
    implements _$$_AppTokenCopyWith<$Res> {
  __$$_AppTokenCopyWithImpl(
      _$_AppToken _value, $Res Function(_$_AppToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$_AppToken(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppToken implements _AppToken {
  const _$_AppToken({this.token = ''});

  factory _$_AppToken.fromJson(Map<String, dynamic> json) =>
      _$$_AppTokenFromJson(json);

  @override
  @JsonKey()
  final String token;

  @override
  String toString() {
    return 'AppToken(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppToken &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppTokenCopyWith<_$_AppToken> get copyWith =>
      __$$_AppTokenCopyWithImpl<_$_AppToken>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppTokenToJson(
      this,
    );
  }
}

abstract class _AppToken implements AppToken {
  const factory _AppToken({final String token}) = _$_AppToken;

  factory _AppToken.fromJson(Map<String, dynamic> json) = _$_AppToken.fromJson;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$_AppTokenCopyWith<_$_AppToken> get copyWith =>
      throw _privateConstructorUsedError;
}
