import 'package:json_annotation/json_annotation.dart';

import 'instagram_model.dart';

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

@override
List<InstagramPlan> instagramPlanFromJson(Map<String, dynamic> json) {
  var list = json['plans'] as List<dynamic>;
  return list.map((e) => InstagramPlan.fromJson(e)).toList();
}

@override
Map<String, dynamic> instagramPlanToJson(List<InstagramPlan> object) {
  return {
    'plans': object.map((e) => e.toJson()).toList(),
  };
}

@override
List<Type> typesFromJson(Map<String, dynamic> json) {
  return json.entries.map((e) => Type.fromJson(e.value)).toList();
}

@override
Map<String, dynamic> typesToJson(List<Type> object) {
  Map<String, dynamic> json = {};
  var i = 1;
  for (var e in object) {
    json['t$i'] = e.toJson();
  }
  return json;
}

@override
List<Extra>? extraFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  return json.entries.map((e) => Extra.fromJson(e.value)).toList();
}

@override
Map<String, dynamic>? extraToJson(List<Extra>? object) {
  if (object == null) return null;
  Map<String, dynamic> json = {};
  var i = 1;
  for (var e in object) {
    json['e$i'] = e.toJson();
  }
  return json;
}
