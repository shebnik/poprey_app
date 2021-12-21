import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/ui/sheets/bottom_sheet/app_bottom_sheet_controller.dart';
import 'package:poprey_app/ui/sheets/choose_account/choose_account.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet.dart';

class AppBottomSheet extends StatefulWidget {
  final SelectedPlan selectedPlan;

  const AppBottomSheet({
    required this.selectedPlan,
    Key? key,
  }) : super(key: key);

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late AppBottomSheetController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AppBottomSheetController(widget.selectedPlan));
  }

  @override
  Widget build(BuildContext context) {
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
            return ChooseAccount(
              profiles: profiles,
              profileSelected: controller.profileSelected,
              addAccount: controller.addAccount,
              profileRemoved: controller.profileRemoved,
            );
          });
        case BottomSheetView.autoLikes:
          // TODO: Handle this case.
          return Container();
      }
    });
  }
}
