import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

/// 使用时 必须保证属性和 `JsonConverter<String, dynamic>` 中的 `String` 一直

class JsonAlwaysString extends JsonConverter<String, dynamic> {
  const JsonAlwaysString();

  @override
  String fromJson(json) {
    if (json is String) return json;
    return '$json';
  }

  @override
  dynamic toJson(object) => object;
}

class JsonAlwaysList extends JsonConverter<List, dynamic> {
  const JsonAlwaysList();

  @override
  List fromJson(json) {
    if (json is List) return json;
    return [];
  }

  @override
  dynamic toJson(object) => object;
}

class JsonMaybeString extends JsonConverter<String?, dynamic> {
  const JsonMaybeString();

  @override
  String? fromJson(json) {
    if (json == null) return null;
    if (json is String) return json;
    return json.toString();
  }

  @override
  dynamic toJson(object) => object;
}

class JsonAlwaysNum implements JsonConverter<num, dynamic> {
  const JsonAlwaysNum();

  @override
  num fromJson(dynamic json) {
    if (json is num) return json;
    return num.tryParse(json) ?? 0;
  }

  @override
  num toJson(num object) => object;
}

class JsonAlwaysInt implements JsonConverter<int, dynamic> {
  const JsonAlwaysInt();

  @override
  int fromJson(dynamic json) {
    if (json is int) return json;
    return (double.tryParse('$json') ?? 0).toInt();
  }

  @override
  int toJson(int object) => object;
}

/// 正整数解析
class JsonPositiveNum implements JsonConverter<num, dynamic> {
  const JsonPositiveNum();

  @override
  num fromJson(dynamic json) {
    if (json == null) return 0;
    num temp = 0;
    if (json is num) temp = json;
    return max(temp, 0);
  }

  @override
  num toJson(num object) => object;
}

// 处理服务器返回枚举数据
// {"name": "xxxx", "value": xxx}
int? jsonReadEnum(Map map, String b) {
  return map[b]?['value'];
}

// 处理服务器返回图片数据
// {"path": "xxxx", "url": xxx}
String? jsonReadImage(Map map, String b) {
  if (map[b] is String) {
    return map[b];
  }
  if (map[b] is Map) {
    return map[b]?['url'];
  }
  return null;
}

bool readBool(Map map, String b) {
  return map[b]?['value'] == 1;
}
