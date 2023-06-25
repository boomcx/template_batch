import 'package:freezed_annotation/freezed_annotation.dart';
part 'app_token.freezed.dart';
part 'app_token.g.dart';

@freezed
class AppToken with _$AppToken {
  const factory AppToken({
    @Default('') String token,
  }) = _AppToken;
  factory AppToken.fromJson(Map<String, Object?> json) =>
      _$AppTokenFromJson(json);
}
