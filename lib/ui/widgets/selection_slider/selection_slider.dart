import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider_controller.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/hex_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectionSlider extends StatefulWidget {
  final String title;
  final InstagramPlan plan;

  const SelectionSlider({
    Key? key,
    required this.title,
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
    controller = Get.put(SelectionSliderController());
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
        child: Material(
          // color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '200',
                          style: TextStyle(
                            color: AppTheme.black(1),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '\$5.90',
                          style: TextStyle(
                            color: AppTheme.black(1),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => SizedBox(
                        height: 27,
                        child: Slider(
                          value: controller.currentValue.value,
                          min: 26,
                          max: 20000,
                          divisions: 10,
                          onChanged: (value) {
                            print(value);
                            controller.currentValue.value = value;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              buySide(),
            ],
          ),
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
                    fontFamily: 'SF Pro Text',
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
