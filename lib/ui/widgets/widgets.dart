import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/app_bottom_sheet.dart';

class Widgets {
  static Widget get loading => const Center(child: CircularProgressIndicator());

  static void showBottomSheet(SelectedPlan selectedPlan) {
    Get.bottomSheet(
      AppBottomSheet(selectedPlan: selectedPlan),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}