// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoList _$VideoListFromJson(Map<String, dynamic> json) => VideoList(
      id: json['id'] == null ? '0' : _stringFromJson(json['id']),
      title: json['title'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userPic: json['userPic'] as String? ?? '',
      coverUrl: json['coverUrl'] as String? ?? '',
      playUrl: json['playUrl'] as String? ?? '',
      duration: json['duration'] == null
          ? '00:00'
          : _stringFromJson(json['duration']),
    );

Map<String, dynamic> _$VideoListToJson(VideoList instance) => <String, dynamic>{
      'id': _stringToJson(instance.id),
      'title': instance.title,
      'userName': instance.userName,
      'userPic': instance.userPic,
      'coverUrl': instance.coverUrl,
      'playUrl': instance.playUrl,
      'duration': _stringToJson(instance.duration),
    };
