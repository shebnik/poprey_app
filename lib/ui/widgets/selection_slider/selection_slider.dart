import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider_controller.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/hex_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectionSlider extends StatefulWidget {
  final String planTitle;
  final InstagramPlan plan;

  const SelectionSlider({
    Key? key,
    required this.planTitle,
    required this.plan,
  }) : super(key: key);

  @override
  State<SelectionSlider> createState() => _SelectionSliderState();
}

class _SelectionSliderState extends State<SelectionSlider> {
  late SelectionSliderController controller;

  @override
  void initState() {
    super.initState();
    controller = SelectionSliderController(widget.plan);
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
        padding: const EdgeInsets.only(top: 10, bottom: 9.5, left: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.planTitle,
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
                        min: controller.minValue,
                        max: controller.maxValue,
                        divisions: controller.divisions,
                        onChanged: controller.onSliderChanged,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.minValue.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        controller.maxValue.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  )
                ],
              ),
            ),
            buySide(),
          ],
        ),
      ),
    );
  }

  Widget buySide() {
    return SizedBox(
      width: 110,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 5,
            right: 0,
            child: SvgPicture.asset(
              controller.getAssetByTitle(widget.planTitle)
            ),
          ),
          Positioned(
            right: 10,
            child: SizedBox(
              width: 75,
              height: 36,
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
          ),
        ],
      ),
    );
  }
}
