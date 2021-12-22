class SelectionSliderModel {
  /// Instagram, YouTube, etc
  final String platform;

  /// Likes, Followers, etc
  final String countInfo;

  /// Instagram username, URL to the YouTube Video, etc
  final String urlInfo;

  final List<PlanPrice> plans;
  final String? imageAsset;

  late final double minValue;
  late final double maxValue;
  late final int divisions;

  SelectionSliderModel({
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

  factory SelectionSliderModel.fromMap({
    required String platform,
    required String countInfo,
    required String urlInfo,
    required Map<String, String> plans,
    String? imageAsset,
  }) {
    return SelectionSliderModel(
      platform: platform,
      countInfo: countInfo,
      urlInfo: urlInfo,
      plans: plans.entries
          .map((e) => PlanPrice(
                count: int.parse(e.key.replaceAll(' ', '')),
                price: double.parse(e.value),
              ))
          .toList(),
      imageAsset: imageAsset,
    );
  }

  SelectionSliderModel copyWith({
    String? platform,
    String? countInfo,
    String? urlInfo,
    List<PlanPrice>? plans,
    String? imageAsset,
  }) {
    return SelectionSliderModel(
      platform: platform ?? this.platform,
      countInfo: countInfo ?? this.countInfo,
      urlInfo: urlInfo ?? this.urlInfo,
      plans: plans ?? this.plans,
      imageAsset: imageAsset ?? this.imageAsset,
    );
  }
}

class PlanPrice {
  final int count;
  final double price;

  PlanPrice({
    required this.count,
    required this.price,
  });

  factory PlanPrice.zero() {
    return PlanPrice(count: 0, price: 0);
  }
}
