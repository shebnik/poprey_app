import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/ui/sheets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/utils.dart';

class SelectionSliderController extends GetxController {
  final SelectionSliderModel model;
  PlanPrice planPrice = PlanPrice.zero();

  SelectionSliderController(this.model);

  String? getImageAsset() {
    switch (model.countInfo.toLowerCase()) {
      case 'likes':
        return AppAssets.likes;
      case 'followers':
      case 'playlist followers':
      case 'group followers':
        return AppAssets.followers;
      case 'auto-likes':
      case 'page likes':
      case 'post likes':
        return AppAssets.autoLikes;
      case 'views':
        return AppAssets.views;
      case 'comments':
        return AppAssets.comments;
    }
  }

  void buyPressed(BuildContext context) {
    Widgets.showBottomSheet(
      context,
      AppBottomSheet(
        selectedPlan: SelectedPlan.fromSelectionSliderModel(
          model: model,
          planPrice: planPrice,
        ),
      ),
    );
  }

  void setPlanPrice(PlanPrice value) => planPrice = value;
}
