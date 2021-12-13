import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:poprey_app/models/bool_converter.dart';

part 'instagram_model.g.dart';

@jsonSerializable
class InstagramModel {
  @JsonProperty(name: 'Likes/plans')
  final List<Plan> likes;

  @JsonProperty(name: 'Followers/plans')
  final List<Plan> followers;

  @JsonProperty(name: 'Auto-Likes/plans')
  final List<Plan> autoLikesPost;

  @JsonProperty(name: 'Auto-Likes Subs/plans')
  final List<Plan> autoLikesSubs;

  @JsonProperty(name: 'Views/plans')
  final List<Plan> views;

  @JsonProperty(name: 'Comments/plans')
  final List<Plan> comments;

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

  @override
  String toString() {
    return 'InstagramModel(likes: $likes, followers: $followers, autoLikesPost: $autoLikesPost, autoLikesSubs: $autoLikesSubs, views: $views, comments: $comments)';
  }
}

@jsonSerializable
class Plan {
  @JsonProperty(name: 'count')
  final int count;

  @JsonProperty(name: 'price')
  final double price;

  @JsonProperty(name: 'types/t1')
  final Type type1;
  @JsonProperty(name: 'types/t2')
  final Type type2;

  @JsonProperty(name: 'extra/e1')
  final Extra? extra1;
  @JsonProperty(name: 'extra/e2')
  final Extra? extra2;
  @JsonProperty(name: 'extra/e3')
  final Extra? extra3;

  Plan({
    required this.count,
    required this.price,
    required this.type1,
    required this.type2,
    this.extra1,
    this.extra2,
    this.extra3,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  Map<String, dynamic> toJson() => _$PlanToJson(this);

  @override
  String toString() {
    return 'Plan(count: $count, price: $price, types: $types, extra: $extra)';
  }
}

@jsonSerializable
class Type {
  final String name;
  final double price;

  @JsonProperty(converter: CustomBoolConverter())
  final bool disabled;
  @JsonProperty(converter: CustomBoolConverter())
  final bool discount;

  Type({
    required this.name,
    required this.price,
    required this.disabled,
    required this.discount,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);

  @override
  String toString() {
    return 'Type(name: $name, price: $price, disabled: $disabled, discount: $discount)';
  }
}

@jsonSerializable
class Extra {
  final String name;
  final int count;
  final double price;
  @JsonProperty(converter: CustomBoolConverter())
  final bool disabled;

  Extra({
    required this.name,
    required this.count,
    required this.price,
    required this.disabled,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => _$ExtraFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraToJson(this);

  @override
  String toString() {
    return 'Extra(name: $name, count: $count, price: $price, disabled: $disabled)';
  }
}
