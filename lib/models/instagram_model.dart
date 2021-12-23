import 'package:json_annotation/json_annotation.dart';

import 'package:poprey_app/models/json_converters.dart';

part 'instagram_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InstagramModel {
  @JsonKey(
    name: 'Likes',
    fromJson: instagramPlanFromJson,
    toJson: instagramPlanToJson,
  )
  final List<InstagramPlan> likes;

  @JsonKey(
    name: 'Followers',
    fromJson: instagramPlanFromJson,
    toJson: instagramPlanToJson,
  )
  final List<InstagramPlan> followers;

  @JsonKey(
    name: 'Auto-Likes',
    fromJson: instagramPlanFromJson,
    toJson: instagramPlanToJson,
  )
  final List<InstagramPlan> autoLikesPost;

  @JsonKey(
    name: 'Auto-Likes Subs',
    fromJson: instagramPlanFromJson,
    toJson: instagramPlanToJson,
  )
  final List<InstagramPlan> autoLikesSubs;

  @JsonKey(
    name: 'Views',
    fromJson: instagramPlanFromJson,
    toJson: instagramPlanToJson,
  )
  final List<InstagramPlan> views;

  @JsonKey(
    name: 'Comments',
    fromJson: instagramPlanFromJson,
    toJson: instagramPlanToJson,
  )
  final List<InstagramPlan> comments;

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
  // List<String?> info;
  
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

  InstagramPlan({
    // required this.info,
    required this.count,
    required this.price,
    required this.types,
    required this.extras,
  });

  factory InstagramPlan.fromJson(Map<String, dynamic> json) =>
      _$InstagramPlanFromJson(json);

  Map<String, dynamic> toJson() => _$InstagramPlanToJson(this);
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
