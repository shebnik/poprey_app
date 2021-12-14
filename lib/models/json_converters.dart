import 'package:json_annotation/json_annotation.dart';

class BoolConverter implements JsonConverter<bool, dynamic> {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    json = json.toString();
    return json == '1';
  }

  @override
  String toJson(bool object) {
    return object ? '1' : '0';
  }
}

class NumConverter implements JsonConverter<num, String> {
  const NumConverter();

  @override
  num fromJson(String json) {
    return num.parse(json);
  }

  @override
  String toJson(num object) {
    return object.toString();
  }
}