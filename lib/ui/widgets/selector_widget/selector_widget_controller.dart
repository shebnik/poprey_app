import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/ui/sheets/bottom_sheet/app_bottom_sheet.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/app_assets.dart';

class SelectorWidgetController extends GetxController {
  final SelectorWidgetModel model;
  late Plan plan;

  RxBool isBuyDisabled;

  SelectorWidgetController(this.model)
      : isBuyDisabled = model.plans[0].disabled.obs;

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
          plan: plan,
        ),
      ),
    );
  }

  void setPlan(Plan value, [int? index]) {
    plan = value;
  }

  void updatePlan(Plan value, [int? index]) {
    plan = value;
    isBuyDisabled.value = value.disabled;
  }
}
