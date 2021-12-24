import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/utils/utils.dart';

class AppSlider extends StatefulWidget {
  final SelectorWidgetModel model;
  final int initialIndex;
  final void Function(Plan plan, [int? index]) setPlan;
  final void Function(Plan plan, [int? index]) updatePlan;

  const AppSlider({
    Key? key,
    required this.model,
    this.initialIndex = 0,
    required this.setPlan,
    required this.updatePlan,
  }) : super(key: key);

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  late SelectorWidgetModel model;

  RxString countValue = ''.obs, priceValue = ''.obs;
  RxDouble currentValue = 0.0.obs;

  @override
  void initState() {
    super.initState();
    model = widget.model;

    final Plan plan = model.plans[widget.initialIndex];
    widget.setPlan(plan, widget.initialIndex);

    currentValue = widget.initialIndex.toDouble().obs;
    countValue = Utils.formatNumber(plan.count).obs;
    priceValue = plan.price.toStringAsFixed(2).obs;
  }

  void onSliderChanged(double value) {
    currentValue.value = value;
    var index = value.toInt();

    final plan = model.plans[index];
    widget.updatePlan(plan, index);

    countValue.value = Utils.formatNumber(plan.count);
    priceValue.value = plan.price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                countValue.value,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Obx(
              () => Text(
                '\$${priceValue.value}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 27,
          child: Obx(
            () => Slider(
              value: currentValue.value,
              min: 0.0,
              max: widget.model.divisions.toDouble(),
              divisions: widget.model.divisions,
              onChanged: onSliderChanged,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Utils.formatNumber(model.plans.first.count),
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              Utils.formatNumber(model.plans.last.count),
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ],
    );
  }
}
