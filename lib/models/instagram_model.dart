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

  @JsonKey(name: 'types')
  final Map<String, Type> type;

  @JsonKey(name: 'extra')
  final Map<String, Extra>? extra;

  Plan({
    required this.count,
    required this.price,
    required this.type,
    required this.extra,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);
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
