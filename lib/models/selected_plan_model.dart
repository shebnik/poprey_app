import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:collection/collection.dart';

class SelectedPlan {
  /// Instagram, YouTube, etc
  final String platform;

  /// Likes, Followers, etc
  final String countInfo;

  /// Instagram username, URL to the YouTube Video, etc
  final String urlInfo;

  final Plan plan;

  /// Instagram username (Login) or link
  final String? url;

  /// User email
  final String? email;

  SelectedPlan({
    required this.platform,
    required this.countInfo,
    required this.urlInfo,
    required this.plan,
    this.url,
    this.email,
  });

  SelectedPlan copyWith({
    String? platform,
    String? countInfo,
    String? urlInfo,
    Plan? plan,
    String? url,
    String? email,
  }) {
    return SelectedPlan(
      platform: platform ?? this.platform,
      countInfo: countInfo ?? this.countInfo,
      urlInfo: urlInfo ?? this.urlInfo,
      plan: plan ?? this.plan,
      url: url ?? this.url,
      email: email ?? this.email,
    );
  }

  factory SelectedPlan.fromSelectionSliderModel({
    required SelectorWidgetModel model,
    required Plan plan,
  }) {
    return SelectedPlan(
      platform: model.platform,
      countInfo: model.countInfo,
      urlInfo: model.urlInfo,
      plan: plan,
    );
  }

  static InstagramPlan? toInstagramPlan(SelectedPlan selectedPlan) {
    try {
      final model = AppPreferences.getInstagramModel()!;
      List<InstagramPlan> list = [];
      switch (selectedPlan.countInfo) {
        case 'Likes':
          list = model.likes;
          break;
        case 'Auto-Likes Post':
          list = model.autoLikesPost;
          break;
        case 'Auto-Likes Subs':
          list = model.autoLikesSubs;
          break;
        case 'Comments':
          list = model.comments;
          break;
        case 'Followers':
          list = model.followers;
          break;
        case 'Views':
          list = model.views;
          break;
      }
      return list
          .firstWhere((element) => element.count == selectedPlan.plan.count);
    } catch (e) {
      Logger.e('[SelectedPlan] toInstagramPlan error:', e);
    }
  }

  static SMPlan? toSMPlan(SelectedPlan selectedPlan) {
    try {
      final model = AppPreferences.getSMPlansModel()!;
      final countInfo = selectedPlan.countInfo.toLowerCase();
      switch (selectedPlan.platform.toLowerCase()) {
        case 'youtube':
          return model.youtube.entries.firstWhereOrNull((e) => e.value.countInfo.toLowerCase() == countInfo)?.value;
        case 'tiktok':
          return model.tiktok.entries.firstWhereOrNull((e) => e.value.countInfo.toLowerCase() == countInfo)?.value;
        case 'facebook':
          return model.facebook.entries.firstWhereOrNull((e) => e.value.countInfo.toLowerCase() == countInfo)?.value;
        case 'spotify':
          return model.spotify.entries.firstWhereOrNull((e) => e.value.countInfo.toLowerCase() == countInfo)?.value;
        case 'twitter':
          return model.twitter.entries.firstWhereOrNull((e) => e.value.countInfo.toLowerCase() == countInfo)?.value;
        case 'vk':
          return model.vk.entries.firstWhereOrNull((e) => e.value.countInfo.toLowerCase() == countInfo)?.value;
      }
    } catch (e) {
      Logger.e('[SelectedPlan] toSMPlan error:', e);
    }
  }

  @override
  String toString() {
    return 'SelectedPlan(platform: $platform, countInfo: $countInfo, urlInfo: $urlInfo, plan: $plan, url: $url, email: $email)';
  }
}