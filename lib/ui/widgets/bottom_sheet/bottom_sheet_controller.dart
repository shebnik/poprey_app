import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account.dart';
import 'package:poprey_app/utils/utils.dart';

class BottomSheetController extends GetxController {
  SelectedPlan selectedPlan;

  BottomSheetController(this.selectedPlan);

  final Rx<TextEditingController> userNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;

  RxBool isUserNameError = false.obs;
  RxBool isEmailError = false.obs;

  String get getTitle =>
      '${selectedPlan.platform} ${Utils.formatNumber(selectedPlan.planPrice.count)} ${selectedPlan.countInfo}';

  get getUrlTitle => selectedPlan.urlInfo;

  void expandMorePressed() {
    // TODO
  }

  void resetPressed() {
    userNameController.value.text = '';
    emailController.value.text = '';
  }

  void nextPressed(BuildContext context) {
    Get.toNamed(
      SelectedAccount.routeName,
      arguments: selectedPlan.copyWith(url: 'shebalinik', email: 'shebalin13@gmail.com'),
    );

    // TODO: Uncomment
    // String userName = userNameController.value.text.trim();
    // String email = emailController.value.text.trim().toLowerCase();

    // if (!validate(userName, email)) return;
    // FocusScope.of(context).unfocus();

    // Get.toNamed(
    //   SelectedAccount.routeName,
    //   arguments: selectedPlan.copyWith(url: userName, email: email),
    // );
  }

  bool validate(String userName, String email) {
    if (!GetUtils.isUsername(userName)) {
      isUserNameError.value = true;
      return false;
    } else {
      isUserNameError.value = false;
    }
    if (!GetUtils.isEmail(email)) {
      isEmailError.value = true;
      return false;
    } else {
      isEmailError.value = false;
    }
    return true;
  }
}
