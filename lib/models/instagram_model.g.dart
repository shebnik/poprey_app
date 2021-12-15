// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstagramModel _$InstagramModelFromJson(Map<String, dynamic> json) =>
    InstagramModel(
      likes: InstagramPlan.fromJson(json['Likes'] as Map<String, dynamic>),
      followers:
          InstagramPlan.fromJson(json['Followers'] as Map<String, dynamic>),
      autoLikesPost:
          InstagramPlan.fromJson(json['Auto-Likes'] as Map<String, dynamic>),
      autoLikesSubs: InstagramPlan.fromJson(
          json['Auto-Likes Subs'] as Map<String, dynamic>),
      views: InstagramPlan.fromJson(json['Views'] as Map<String, dynamic>),
      comments:
          InstagramPlan.fromJson(json['Comments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstagramModelToJson(InstagramModel instance) =>
    <String, dynamic>{
      'Likes': instance.likes.toJson(),
      'Followers': instance.followers.toJson(),
      'Auto-Likes': instance.autoLikesPost.toJson(),
      'Auto-Likes Subs': instance.autoLikesSubs.toJson(),
      'Views': instance.views.toJson(),
      'Comments': instance.comments.toJson(),
    };

InstagramPlan _$InstagramPlanFromJson(Map<String, dynamic> json) =>
    InstagramPlan(
      plans: (json['plans'] as List<dynamic>)
          .map((e) => Plan.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: (json['info'] as List<dynamic>).map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$InstagramPlanToJson(InstagramPlan instance) =>
    <String, dynamic>{
      'plans': instance.plans.map((e) => e.toJson()).toList(),
      'info': instance.info,
    };

Plan _$PlanFromJson(Map<String, dynamic> json) => Plan(
      count: const NumConverter().fromJson(json['count'] as String),
      price: const NumConverter().fromJson(json['price'] as String),
      types: typesFromJson(json['types'] as Map<String, dynamic>),
      extras: extraFromJson(json['extra'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
      'count': const NumConverter().toJson(instance.count),
      'price': const NumConverter().toJson(instance.price),
      'types': typesToJson(instance.types),
      'extra': extraToJson(instance.extras),
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      name: json['name'] as String,
      price: const NumConverter().fromJson(json['price'] as String),
      disabled: const BoolConverter().fromJson(json['disabled']),
      discount: const BoolConverter().fromJson(json['discount']),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'name': instance.name,
      'price': const NumConverter().toJson(instance.price),
      'disabled': const BoolConverter().toJson(instance.disabled),
      'discount': const BoolConverter().toJson(instance.discount),
    };

Extra _$ExtraFromJson(Map<String, dynamic> json) => Extra(
      name: json['name'] as String,
      count: const NumConverter().fromJson(json['count'] as String),
      price: const NumConverter().fromJson(json['price'] as String),
      disabled: const BoolConverter().fromJson(json['disabled']),
    );

Map<String, dynamic> _$ExtraToJson(Extra instance) => <String, dynamic>{
      'name': instance.name,
      'count': const NumConverter().toJson(instance.count),
      'price': const NumConverter().toJson(instance.price),
      'disabled': const BoolConverter().toJson(instance.disabled),
    };
