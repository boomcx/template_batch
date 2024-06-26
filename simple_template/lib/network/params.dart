import 'package:json_annotation/json_annotation.dart';

// 接口请求参数
part 'params.g.dart';

@JsonSerializable()
class TokenParams {
  @JsonKey(name: 'client_id')
  final String clientId;

  TokenParams(this.clientId);
  factory TokenParams.fromJson(Map<String, Object?> json) =>
      _$TokenParamsFromJson(json);
  Map<String, dynamic> toJson() => _$TokenParamsToJson(this);
}
