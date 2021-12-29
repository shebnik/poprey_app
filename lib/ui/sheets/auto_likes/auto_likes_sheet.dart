import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/sheets/auto_likes/auto_likes_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/app_slider.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:poprey_app/ui/widgets/selection_container/selection_containers_row.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class AutoLikesSheet extends StatefulWidget {
  final SelectedPlan selectedPlan;
  final VoidCallback resetPressed;
  final void Function(SelectedPlan) nextPressed;

  const AutoLikesSheet({
    Key? key,
    required this.selectedPlan,
    required this.resetPressed,
    required this.nextPressed,
  }) : super(key: key);

  @override
  State<AutoLikesSheet> createState() => _AutoLikesSheetState();
}

class _AutoLikesSheetState extends State<AutoLikesSheet> {
  late AutoLikesSheetController controller;
  @override
  void initState() {
    super.initState();
    controller = AutoLikesSheetController(widget.selectedPlan);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 5),
          const Center(child: HomeIndicator()),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Icon(
                Icons.close,
                color: Color(0xFFC9CFD6),
                size: 15,
              ),
              onTap: () => Get.back(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SelectionContainersRow(
              selectedIndex: controller.selectedIndex,
              updateIndex: (index) => controller.selectedIndex.value = index,
              title1: AppLocale(context).perPost.toUpperCase(),
              title2: AppLocale(context).subscription.toUpperCase(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 34.0),
            child: Obx(
              () => Text(
                controller.selectedIndex.value == 0
                    ? AppLocale(context).forNewPosts
                    : AppLocale(context).subscription,
                style: const TextStyle(
                  color: AppTheme.primaryBlue,
                  fontFamily: AppConstants.SFProDisplay,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Obx(
              () => AppSlider(
                key: Key('Auto-Likes-Slider-${controller.selectedIndex.value}'),
                model: controller.getSelectedModel(),
                initialIndex: controller.getInititalIndex(),
                setPlan: controller.setPlan,
                updatePlan: controller.updatePlan,
              ),
            ),
          ),
          const SizedBox(height: 35, width: 35),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Obx(
              () => BottomResetNavigation(
                resetPressed: widget.resetPressed,
                nextPressed: controller.isBuyDisabled.value
                    ? null
                    : () => widget.nextPressed(controller.getSelectedPlan()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
