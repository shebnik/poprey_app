import 'package:json_annotation/json_annotation.dart';

import 'package:poprey_app/models/json_converters.dart';

part 'instagram_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InstagramModel {
  @JsonKey(name: 'Likes')
  final InstagramPlan likes;

  @JsonKey(name: 'Followers')
  final InstagramPlan followers;

  @JsonKey(name: 'Auto-Likes')
  final InstagramPlan autoLikesPost;

  @JsonKey(name: 'Auto-Likes Subs')
  final InstagramPlan autoLikesSubs;

  @JsonKey(name: 'Views')
  final InstagramPlan views;

  @JsonKey(name: 'Comments')
  final InstagramPlan comments;

  InstagramModel({
    required this.likes,
    required this.followers,
    required this.autoLikesPost,
    required this.autoLikesSubs,
    required this.views,
    required this.comments,
  });

  factory InstagramModel.fromJson(Map<String, dynamic> json) =>
      _$InstagramModelFromJson(json);

  Map<String, dynamic> toJson() => _$InstagramModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InstagramPlan {
  List<Plan> plans;
  List<String?> info;

  InstagramPlan({
    required this.plans,
    required this.info,
  });

  factory InstagramPlan.fromJson(Map<String, dynamic> json) =>
      _$InstagramPlanFromJson(json);

  Map<String, dynamic> toJson() => _$InstagramPlanToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Plan {
  @NumConverter()
  @JsonKey(name: 'count')
  final num count;

  @NumConverter()
  @JsonKey(name: 'price')
  final num price;

  @JsonKey(
    name: 'types',
    fromJson: typesFromJson,
    toJson: typesToJson,
  )
  final List<Type> types;

  @JsonKey(
    name: 'extra',
    fromJson: extraFromJson,
    toJson: extraToJson,
  )
  final List<Extra>? extras;

  Plan({
    required this.count,
    required this.price,
    required this.types,
    required this.extras,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
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

@JsonSerializable(explicitToJson: true)
class Type {
  final String name;

  @NumConverter()
  final num price;

  @BoolConverter()
  final bool disabled;

  @BoolConverter()
  final bool discount;

  Type({
    required this.name,
    required this.price,
    required this.disabled,
    required this.discount,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Extra {
  final String name;

  @NumConverter()
  final num count;

  @NumConverter()
  final num price;

  @BoolConverter()
  final bool disabled;

  Extra({
    required this.name,
    required this.count,
    required this.price,
    required this.disabled,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => _$ExtraFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraToJson(this);
}
