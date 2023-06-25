import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template_getx/common/extensions/json_extension.dart';
part 'video_list.freezed.dart';
part 'video_list.g.dart';

@freezed
class VideoList with _$VideoList {
  const factory VideoList({
    @JsonAlwaysString() @Default('0') String id,
    @Default('') String title,
    @Default('') String userName,
    @Default('') String userPic,
    @Default('') String coverUrl,
    @Default('') String playUrl,
    @JsonAlwaysString() @Default('00:00') String duration,
  }) = _VideoList;
  factory VideoList.fromJson(Map<String, Object?> json) =>
      _$VideoListFromJson(json);
}
