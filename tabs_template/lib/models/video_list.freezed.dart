// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VideoList _$VideoListFromJson(Map<String, dynamic> json) {
  return _VideoList.fromJson(json);
}

/// @nodoc
mixin _$VideoList {
  @JsonAlwaysString()
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userPic => throw _privateConstructorUsedError;
  String get coverUrl => throw _privateConstructorUsedError;
  String get playUrl => throw _privateConstructorUsedError;
  @JsonAlwaysString()
  String get duration => throw _privateConstructorUsedError;

  /// Serializes this VideoList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VideoList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VideoListCopyWith<VideoList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoListCopyWith<$Res> {
  factory $VideoListCopyWith(VideoList value, $Res Function(VideoList) then) =
      _$VideoListCopyWithImpl<$Res, VideoList>;
  @useResult
  $Res call(
      {@JsonAlwaysString() String id,
      String title,
      String userName,
      String userPic,
      String coverUrl,
      String playUrl,
      @JsonAlwaysString() String duration});
}

/// @nodoc
class _$VideoListCopyWithImpl<$Res, $Val extends VideoList>
    implements $VideoListCopyWith<$Res> {
  _$VideoListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VideoList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? userName = null,
    Object? userPic = null,
    Object? coverUrl = null,
    Object? playUrl = null,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPic: null == userPic
          ? _value.userPic
          : userPic // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
      playUrl: null == playUrl
          ? _value.playUrl
          : playUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VideoListImplCopyWith<$Res>
    implements $VideoListCopyWith<$Res> {
  factory _$$VideoListImplCopyWith(
          _$VideoListImpl value, $Res Function(_$VideoListImpl) then) =
      __$$VideoListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonAlwaysString() String id,
      String title,
      String userName,
      String userPic,
      String coverUrl,
      String playUrl,
      @JsonAlwaysString() String duration});
}

/// @nodoc
class __$$VideoListImplCopyWithImpl<$Res>
    extends _$VideoListCopyWithImpl<$Res, _$VideoListImpl>
    implements _$$VideoListImplCopyWith<$Res> {
  __$$VideoListImplCopyWithImpl(
      _$VideoListImpl _value, $Res Function(_$VideoListImpl) _then)
      : super(_value, _then);

  /// Create a copy of VideoList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? userName = null,
    Object? userPic = null,
    Object? coverUrl = null,
    Object? playUrl = null,
    Object? duration = null,
  }) {
    return _then(_$VideoListImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userPic: null == userPic
          ? _value.userPic
          : userPic // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: null == coverUrl
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as String,
      playUrl: null == playUrl
          ? _value.playUrl
          : playUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VideoListImpl implements _VideoList {
  const _$VideoListImpl(
      {@JsonAlwaysString() this.id = '0',
      this.title = '',
      this.userName = '',
      this.userPic = '',
      this.coverUrl = '',
      this.playUrl = '',
      @JsonAlwaysString() this.duration = '00:00'});

  factory _$VideoListImpl.fromJson(Map<String, dynamic> json) =>
      _$$VideoListImplFromJson(json);

  @override
  @JsonKey()
  @JsonAlwaysString()
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String userName;
  @override
  @JsonKey()
  final String userPic;
  @override
  @JsonKey()
  final String coverUrl;
  @override
  @JsonKey()
  final String playUrl;
  @override
  @JsonKey()
  @JsonAlwaysString()
  final String duration;

  @override
  String toString() {
    return 'VideoList(id: $id, title: $title, userName: $userName, userPic: $userPic, coverUrl: $coverUrl, playUrl: $playUrl, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VideoListImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userPic, userPic) || other.userPic == userPic) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl) &&
            (identical(other.playUrl, playUrl) || other.playUrl == playUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, userName, userPic, coverUrl, playUrl, duration);

  /// Create a copy of VideoList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VideoListImplCopyWith<_$VideoListImpl> get copyWith =>
      __$$VideoListImplCopyWithImpl<_$VideoListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VideoListImplToJson(
      this,
    );
  }
}

abstract class _VideoList implements VideoList {
  const factory _VideoList(
      {@JsonAlwaysString() final String id,
      final String title,
      final String userName,
      final String userPic,
      final String coverUrl,
      final String playUrl,
      @JsonAlwaysString() final String duration}) = _$VideoListImpl;

  factory _VideoList.fromJson(Map<String, dynamic> json) =
      _$VideoListImpl.fromJson;

  @override
  @JsonAlwaysString()
  String get id;
  @override
  String get title;
  @override
  String get userName;
  @override
  String get userPic;
  @override
  String get coverUrl;
  @override
  String get playUrl;
  @override
  @JsonAlwaysString()
  String get duration;

  /// Create a copy of VideoList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VideoListImplCopyWith<_$VideoListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
