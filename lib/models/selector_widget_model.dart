import 'package:poprey_app/models/instagram_model.dart';

class SelectorWidgetModel {
  /// Instagram, YouTube, etc
  final String platform;

  /// Likes, Followers, etc
  final String countInfo;

  /// Instagram username, URL to the YouTube Video, etc
  final String urlInfo;

  final List<Plan> plans;
  final String? imageAsset;

  late final double minValue;
  late final double maxValue;
  late final int divisions;

  SelectorWidgetModel({
    required this.platform,
    required this.countInfo,
    required this.urlInfo,
    required this.plans,
    this.imageAsset,
  }) {
    if (plans.isNotEmpty) {
      minValue = plans.first.price;
      maxValue = plans.last.price;
      divisions = plans.length - 1;
    }
  }

  factory SelectorWidgetModel.fromSMMap({
    required String platform,
    required String countInfo,
    required String urlInfo,
    required Map<String, String> plans,
    String? imageAsset,
  }) {
    return SelectorWidgetModel(
      platform: platform,
      countInfo: countInfo,
      urlInfo: urlInfo,
      plans: plans.entries
          .map((e) => Plan(
                count: int.parse(e.key.replaceAll(' ', '')),
                price: double.parse(e.value),
                disabled: false,
              ))
          .toList(),
      imageAsset: imageAsset,
    );
  }

  SelectorWidgetModel copyWith({
    String? platform,
    String? countInfo,
    String? urlInfo,
    List<Plan>? plans,
    String? imageAsset,
  }) {
    return SelectorWidgetModel(
      platform: platform ?? this.platform,
      countInfo: countInfo ?? this.countInfo,
      urlInfo: urlInfo ?? this.urlInfo,
      plans: plans ?? this.plans,
      imageAsset: imageAsset ?? this.imageAsset,
    );
  }
}

class Plan {
  final int count;
  final double price;
  final bool disabled;

  Plan({
    required this.count,
    required this.price,
    required this.disabled,
  });

  factory Plan.zero() {
    return Plan(count: 0, price: 0, disabled: false);
  }

  static bool checkIfDisabled(List<PlanType> types) {
    return types[0].disabled && types[1].disabled;
  }
}
