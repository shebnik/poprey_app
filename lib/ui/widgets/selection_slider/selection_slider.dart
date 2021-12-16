import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider_controller.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectionSlider extends StatefulWidget {
  final SelectionSliderModel model;

  const SelectionSlider({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<SelectionSlider> createState() => _SelectionSliderState();
}

class _SelectionSliderState extends State<SelectionSlider> {
  late final SelectionSliderModel model;
  late final SelectionSliderController controller;

  final double buyWidgetWidth = 110;

  @override
  void initState() {
    super.initState();
    model = widget.model;

    controller = SelectionSliderController(model);
    controller.initValues();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F8FB),
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: model.imageAsset != null ? 0.0 : 14.0,
          right: 0,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: buyWidget(),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: constraints.minWidth - buyWidgetWidth,
                  ),
                  child: sliderWidget(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget sliderWidget() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.imageAsset != null) ...[
          SizedBox(
            width: 30,
            height: 30,
            child: ClipOval(
              child: SvgPicture.asset(
                model.imageAsset!,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Column(
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
                      controller.countValue.value,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.getPriceAmmount,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              ),
              Obx(
                () => SizedBox(
                  height: 27,
                  child: Slider(
                    value: controller.currentValue.value,
                    min: 0.0,
                    max: model.divisions.toDouble(),
                    divisions: model.divisions,
                    onChanged: controller.onSliderChanged,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.minValue,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    controller.maxValue,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buyWidget() {
    final imageAsset = controller.getImageAsset();
    return SizedBox(
      width: buyWidgetWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (imageAsset != null) ...[
            Positioned(
              top: 5,
              right: 0,
              child: SvgPicture.asset(
                imageAsset,
              ),
            ),
          ],
          Positioned(
            right: 10,
            child: RoundButton(
              title: AppLocalizations.of(context)!.buy,
              onPressed: controller.buyPressed,
              fontWeightDelta: 2,
            ),
          ),
        ],
      ),
    );
  }
}