import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';

class AppSlider extends StatefulWidget {
  final SelectionSliderModel model;
  final void Function(PlanPrice planPrice) setPlanPrice;

  const AppSlider({
    Key? key,
    required this.model,
    required this.setPlanPrice,
  }) : super(key: key);

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  late SelectionSliderModel model;

  RxString countValue = ''.obs, priceValue = ''.obs;
  RxDouble currentValue = 0.0.obs;

  @override
  void initState() {
    super.initState();
    model = widget.model;

    widget.setPlanPrice(PlanPrice(
      count: model.plans[0].count,
      price: model.plans[0].price,
    ));

    countValue = Utils.formatNumber(model.plans.first.count).obs;
    priceValue = model.plans.first.price.toStringAsFixed(2).obs;
  }

  void onSliderChanged(double value) {
    currentValue.value = value;
    var index = value.toInt();

    var count = model.plans[index].count;
    var price = model.plans[index].price;
    widget.setPlanPrice(PlanPrice(count: count, price: price));

    countValue.value = Utils.formatNumber(count);
    priceValue.value = price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.countInfo,
          style: Theme.of(context).textTheme.headline5!.apply(
                color: AppTheme.primaryBlue,
              ),
        ),
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
