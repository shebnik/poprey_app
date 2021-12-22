import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/ui/sheets/auto_likes/auto_likes_sheet.dart';
import 'package:poprey_app/ui/sheets/bottom_sheet/app_bottom_sheet_controller.dart';
import 'package:poprey_app/ui/sheets/choose_account/choose_account.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet.dart';

class AppBottomSheet extends StatelessWidget {
  final SelectedPlan selectedPlan;

  const AppBottomSheet({
    required this.selectedPlan,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = AppBottomSheetController(selectedPlan);
    return Obx(() {
      switch (controller.bottomSheetView.value) {
        case BottomSheetView.login:
          return LoginSheet(
            controller: controller.loginSheetController,
          );
        case BottomSheetView.chooseAccount:
          return Obx(() {
            // ignore: invalid_use_of_protected_member
            var profiles = controller.profilesManager.profiles.value;
            return ChooseAccountSheet(
              profiles: profiles,
              profileSelected: controller.profileSelected,
              addAccount: controller.addAccount,
              profileRemoved: controller.profileRemoved,
            );
          });
        case BottomSheetView.autoLikes:
          return const AutoLikesSheet();
      }
    });
  }
}
