import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// 用户信息。
@JsonSerializable()
class User {
  const User({
    this.name = '',
    this.uid = '',
  });
  final String name;
  final String uid;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
