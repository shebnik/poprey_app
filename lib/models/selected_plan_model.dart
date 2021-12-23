import 'package:poprey_app/models/selection_slider_model.dart';

class SelectedPlan {
  /// Instagram, YouTube, etc
  final String platform;

  /// Likes, Followers, etc
  final String countInfo;

  /// Instagram username, URL to the YouTube Video, etc
  final String urlInfo;

  final Plan planPrice;
  
  /// Instagram username (Login) or link
  final String? url;
  
  /// User email
  final String? email;

  SelectedPlan({
    required this.platform,
    required this.countInfo,
    required this.urlInfo,
    required this.planPrice,
    this.url,
    this.email,
  });

  SelectedPlan copyWith({
    String? platform,
    String? countInfo,
    String? urlInfo,
    Plan? planPrice,
    String? url,
    String? email,
  }) {
    return SelectedPlan(
      platform: platform ?? this.platform,
      countInfo: countInfo ?? this.countInfo,
      urlInfo: urlInfo ?? this.urlInfo,
      planPrice: planPrice ?? this.planPrice,
      url: url ?? this.url,
      email: email ?? this.email,
    );
  }

  factory SelectedPlan.fromSelectionSliderModel({
    required SelectionSliderModel model,
    required Plan planPrice,
  }) {
    return SelectedPlan(
      platform: model.platform,
      countInfo: model.countInfo,
      urlInfo: model.urlInfo,
      planPrice: planPrice,
    );
  }
}
