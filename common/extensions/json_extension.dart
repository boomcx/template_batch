import 'package:freezed_annotation/freezed_annotation.dart';

class JsonAlwaysString extends JsonConverter<String, dynamic> {
  const JsonAlwaysString();

  @override
  String fromJson(json) {
    if (json is String) return json;
    return json.toString();
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
