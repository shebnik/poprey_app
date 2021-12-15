// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sm_plans_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SMPlansModel _$SMPlansModelFromJson(Map<String, dynamic> json) => SMPlansModel(
      youtube: (json['YouTube'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SMPlan.fromJson(e as Map<String, dynamic>)),
      ),
      tiktok: (json['TikTok'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SMPlan.fromJson(e as Map<String, dynamic>)),
      ),
      facebook: (json['Facebook'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SMPlan.fromJson(e as Map<String, dynamic>)),
      ),
      twitter: (json['Twitter'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SMPlan.fromJson(e as Map<String, dynamic>)),
      ),
      spotify: (json['Spotify'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SMPlan.fromJson(e as Map<String, dynamic>)),
      ),
      vk: (json['Vk.com'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, SMPlan.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$SMPlansModelToJson(SMPlansModel instance) =>
    <String, dynamic>{
      'YouTube': instance.youtube.map((k, e) => MapEntry(k, e.toJson())),
      'TikTok': instance.tiktok.map((k, e) => MapEntry(k, e.toJson())),
      'Facebook': instance.facebook.map((k, e) => MapEntry(k, e.toJson())),
      'Twitter': instance.twitter.map((k, e) => MapEntry(k, e.toJson())),
      'Spotify': instance.spotify.map((k, e) => MapEntry(k, e.toJson())),
      'Vk.com': instance.vk.map((k, e) => MapEntry(k, e.toJson())),
    };

SMPlan _$SMPlanFromJson(Map<String, dynamic> json) => SMPlan(
      logo: json['logo'] as String,
      countInfo: json['count_info'] as String,
      urlInfo: json['url_info'] as String,
      plans: Map<String, String>.from(json['plans'] as Map),
      info: (json['info'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SMPlanToJson(SMPlan instance) => <String, dynamic>{
      'logo': instance.logo,
      'count_info': instance.countInfo,
      'url_info': instance.urlInfo,
      'plans': instance.plans,
      'info': instance.info,
    };
