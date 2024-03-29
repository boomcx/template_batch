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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$AppTokenImplCopyWith<_$AppTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
