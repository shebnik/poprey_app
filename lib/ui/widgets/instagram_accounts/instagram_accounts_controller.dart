import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/app_widgets.dart';

class InstagramAccountsController extends GetxController {
  final InstagramProfilesManager profilesManager;
  final void Function(InstagramProfile) accountSelected;

  final SelectedPlan selectedPlan;
  final Future<void> Function(
          InstagramProfile profile, Map<String, dynamic>? instagramUser)
      profileSelected;

  InstagramAccountsController({
    required this.profilesManager,
    required this.accountSelected,
    required this.selectedPlan,
    required this.profileSelected,
  });

  late ScrollController accountsListScrollController;
  RxBool isAccountListShown = false.obs;
  RxBool isAccountsShadowShown = false.obs;

  int getAccountListCount() {
    return isAccountListShown.value ? profilesManager.profiles.length : 1;
  }

  LoginSheetController get loginSheetController => LoginSheetController(
        selectedPlan: selectedPlan,
        profilesManager: profilesManager,
        profileSelected: profileAdded,
        linkSelected: (a, b) => {},
      );

  void toggleList() {
    isAccountListShown.value = !isAccountListShown.value;
    if (isAccountListShown.value) {
      // TODO: Improve without jumping (maxscrollextent is 0.0 by default)
      accountsListScrollController.jumpTo(1);
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        accountsListScrollController.jumpTo(0);
      });
    }
  }

  void addAccount(BuildContext context) {
    AppWidgets.showBottomSheet(
      context,
      LoginSheet(controller: loginSheetController),
    );
  }

  bool accountsListScrollControllerNotification(
      ScrollNotification notification) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      isAccountsShadowShown.value =
          notification.metrics.extentAfter > 16 ? true : false;
    });
    return true;
  }

  void accountTap(InstagramProfile profile) {
    if (profilesManager.getSelectedProfile() == profile) {
      toggleList();
      return;
    }
    isAccountListShown.value = false;
    accountSelected(profile);
  }

  void profileAdded(
      InstagramProfile profile, Map<String, dynamic>? instagramUser) {
    if (profilesManager.getSelectedProfile() == profile) {
      Get.back();
      toggleList();
      return;
    }
    isAccountListShown.value = false;
    profileSelected(profile, instagramUser);
  }
}
