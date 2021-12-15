class SelectionSliderModel {
  final String planTitle;
  final List<PlanPrice> plans;

  late final double minValue;
  late final double maxValue;
  late final int divisions;

  SelectionSliderModel({
    required this.planTitle,
    required this.plans,
  }) {
    minValue = plans.first.price;
    maxValue = plans.last.price;
    divisions = plans.length - 1;
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
