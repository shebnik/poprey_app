import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/app_slider.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';
import 'package:poprey_app/ui/widgets/selector_widget/selector_widget_controller.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectorWidget extends StatefulWidget {
  final SelectorWidgetModel model;

  const SelectorWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<SelectorWidget> createState() => _SelectorWidgetState();
}

class _SelectorWidgetState extends State<SelectorWidget> {
  late final SelectorWidgetModel model;
  late final SelectorWidgetController controller;

  final double buyWidgetWidth = 110;

  @override
  void initState() {
    super.initState();
    model = widget.model;

    controller = SelectorWidgetController(model);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.isLightTheme(context)
            ? const Color(0xFFF7F8FB)
            : const Color(0xFF080704),
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: model.imageAsset != null ? 10.0 : 14.0,
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
          ClipOval(
            child: SvgPicture.asset(
              model.imageAsset!,
              height: 29,
              width: 29,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 9),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.countInfo,
                style: Theme.of(context).textTheme.headline5?.apply(
                      color: AppTheme.primaryBlue,
                    ),
              ),
              const SizedBox(height: 0.5),
              AppSlider(
                model: model,
                setPlan: controller.setPlan,
                updatePlan: controller.updatePlan,
              ),
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
            child: Obx(() {
              return RoundButton(
                title: AppLocale(context).buy,
                onPressed: controller.isBuyDisabled.value
                    ? null
                    : () => controller.buyPressed(context),
                fontWeightDelta: 2,
              );
            }),
          ),
        ],
      ),
    );
  }
}
