import 'package:json_annotation/json_annotation.dart';

import 'package:tabs_template/extensions/json_extension.dart';

part 'video_list.g.dart';

/// 视频列表项。
@JsonSerializable()
class VideoList {
  const VideoList({
    this.id = '0',
    this.title = '',       
    this.userName = '',
    this.userPic = '',
    this.coverUrl = '',
    this.playUrl = '',
    this.duration = '00:00',
  });

  @JsonKey(fromJson: _stringFromJson, toJson: _stringToJson)
  final String id;
  final String title;
  final String userName;
  final String userPic;
  final String coverUrl;
  final String playUrl;

  @JsonKey(fromJson: _stringFromJson, toJson: _stringToJson)
  final String duration;

  factory VideoList.fromJson(Map<String, dynamic> json) =>
      _$VideoListFromJson(json);

  Map<String, dynamic> toJson() => _$VideoListToJson(this);
}

String _stringFromJson(Object? json) =>
    const JsonAlwaysString().fromJson(json);

Object? _stringToJson(String object) => const JsonAlwaysString().toJson(object);
