import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider_controller.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/hex_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      decoration: BoxDecoration(
        color: HexColor.fromHex('#F7F8FB'),
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 9.5,
          left: 14,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.planTitle,
          style: Theme.of(context).textTheme.headline5!.apply(
                color: AppTheme.secondary,
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
                '\$${controller.priceValue.value}',
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
              min: model.minValue,
              max: model.maxValue,
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
    );
  }

  Widget buyWidget() {
    return SizedBox(
      width: buyWidgetWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 5,
            right: 0,
            child: SvgPicture.asset(
              controller.getImageAsset(),
            ),
          ),
          Positioned(
            right: 10,
            child: ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.buy,
                style: const TextStyle(
                  fontFamily: AppConstants.SFProText,
                  color: CupertinoColors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
