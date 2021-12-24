import 'package:json_annotation/json_annotation.dart';

part 'sm_plans_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SMPlansModel {
  @JsonKey(name: 'YouTube')
  final Map<String, SMPlan> youtube;

  @JsonKey(name: 'TikTok')
  final Map<String, SMPlan> tiktok;

  @JsonKey(name: 'Facebook')
  final Map<String, SMPlan> facebook;

  @JsonKey(name: 'Twitter')
  final Map<String, SMPlan> twitter;

  @JsonKey(name: 'Spotify')
  final Map<String, SMPlan> spotify;

  @JsonKey(name: 'Vk.com')
  final Map<String, SMPlan> vk;

  SMPlansModel({
    required this.youtube,
    required this.tiktok,
    required this.facebook,
    required this.twitter,
    required this.spotify,
    required this.vk,
  });

  factory SMPlansModel.fromJson(Map<String, dynamic> json) =>
      _$SMPlansModelFromJson(json);

  Map<String, dynamic> toJson() => _$SMPlansModelToJson(this);

  @override
  String toString() {
    return 'SMPlansModel(youtube: $youtube, tiktok: $tiktok, facebook: $facebook, twitter: $twitter, spotify: $spotify, vk: $vk)';
  }
}

@JsonSerializable(explicitToJson: true)
class SMPlan {
  final String logo;

  @JsonKey(name: 'count_info')
  final String countInfo;

  @JsonKey(name: 'url_info')
  final String urlInfo;

  final Map<String, String> plans;
  final List<String> info;
  
  SMPlan({
    required this.logo,
    required this.countInfo,
    required this.urlInfo,
    required this.plans,
    required this.info,
  });

  factory SMPlan.fromJson(Map<String, dynamic> json) => _$SMPlanFromJson(json);

  Map<String, dynamic> toJson() => _$SMPlanToJson(this);

  @override
  String toString() {
    return 'SMPlan(logo: $logo, countInfo: $countInfo, urlInfo: $urlInfo, plans: $plans, info: $info)';
  }
}
