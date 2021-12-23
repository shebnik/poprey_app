// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstagramModel _$InstagramModelFromJson(Map<String, dynamic> json) =>
    InstagramModel(
      likes: instagramPlanFromJson(json['Likes'] as Map<String, dynamic>),
      followers:
          instagramPlanFromJson(json['Followers'] as Map<String, dynamic>),
      autoLikesPost:
          instagramPlanFromJson(json['Auto-Likes'] as Map<String, dynamic>),
      autoLikesSubs: instagramPlanFromJson(
          json['Auto-Likes Subs'] as Map<String, dynamic>),
      views: instagramPlanFromJson(json['Views'] as Map<String, dynamic>),
      comments: instagramPlanFromJson(json['Comments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstagramModelToJson(InstagramModel instance) =>
    <String, dynamic>{
      'Likes': instagramPlanToJson(instance.likes),
      'Followers': instagramPlanToJson(instance.followers),
      'Auto-Likes': instagramPlanToJson(instance.autoLikesPost),
      'Auto-Likes Subs': instagramPlanToJson(instance.autoLikesSubs),
      'Views': instagramPlanToJson(instance.views),
      'Comments': instagramPlanToJson(instance.comments),
    };

InstagramPlan _$InstagramPlanFromJson(Map<String, dynamic> json) =>
    InstagramPlan(
      count: const NumConverter().fromJson(json['count'] as String),
      price: const NumConverter().fromJson(json['price'] as String),
      types: typesFromJson(json['types'] as Map<String, dynamic>),
      extras: extraFromJson(json['extra'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$InstagramPlanToJson(InstagramPlan instance) =>
    <String, dynamic>{
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
