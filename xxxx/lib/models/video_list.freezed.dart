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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_VideoListCopyWith<$Res> implements $VideoListCopyWith<$Res> {
  factory _$$_VideoListCopyWith(
          _$_VideoList value, $Res Function(_$_VideoList) then) =
      __$$_VideoListCopyWithImpl<$Res>;
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
class __$$_VideoListCopyWithImpl<$Res>
    extends _$VideoListCopyWithImpl<$Res, _$_VideoList>
    implements _$$_VideoListCopyWith<$Res> {
  __$$_VideoListCopyWithImpl(
      _$_VideoList _value, $Res Function(_$_VideoList) _then)
      : super(_value, _then);

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
    return _then(_$_VideoList(
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
class _$_VideoList implements _VideoList {
  const _$_VideoList(
      {@JsonAlwaysString() this.id = '0',
      this.title = '',
      this.userName = '',
      this.userPic = '',
      this.coverUrl = '',
      this.playUrl = '',
      @JsonAlwaysString() this.duration = '00:00'});

  factory _$_VideoList.fromJson(Map<String, dynamic> json) =>
      _$$_VideoListFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoList &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, userName, userPic, coverUrl, playUrl, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoListCopyWith<_$_VideoList> get copyWith =>
      __$$_VideoListCopyWithImpl<_$_VideoList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VideoListToJson(
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
      @JsonAlwaysString() final String duration}) = _$_VideoList;

  factory _VideoList.fromJson(Map<String, dynamic> json) =
      _$_VideoList.fromJson;

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
  @override
  @JsonKey(ignore: true)
  _$$_VideoListCopyWith<_$_VideoList> get copyWith =>
      throw _privateConstructorUsedError;
}
