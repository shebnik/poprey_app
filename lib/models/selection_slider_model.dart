class SelectionSliderModel {
  final String name;
  final String planTitle;
  final List<PlanPrice> plans;
  final String? imageAsset;

  late final double minValue;
  late final double maxValue;
  late final int divisions;

  SelectionSliderModel({
    required this.name,
    required this.planTitle,
    required this.plans,
    this.imageAsset,
  }) {
    minValue = plans.first.price;
    maxValue = plans.last.price;
    divisions = plans.length - 1;
  }

  factory SelectionSliderModel.fromMap({
    required String name,
    required String planTitle,
    required Map<String, String> plans,
    String? imageAsset,
  }) {
    return SelectionSliderModel(
      name: name,
      planTitle: planTitle,
      plans: plans.entries
          .map((e) => PlanPrice(
                count: int.parse(e.key.replaceAll(' ', '')),
                price: double.parse(e.value),
              ))
          .toList(),
      imageAsset: imageAsset,
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
}
