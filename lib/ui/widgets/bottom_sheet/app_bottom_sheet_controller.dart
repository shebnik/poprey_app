import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';

import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account.dart';
import 'package:poprey_app/utils/utils.dart';

class BottomSheetController extends GetxController {
  SelectedPlan selectedPlan;

  BottomSheetController(this.selectedPlan);

  AppLocalizations? _localization;
  set localization(AppLocalizations? value) {
    _localization = value;
  }

  AppLocalizations? get localization => _localization;

  RxString userNameErrorText = ''.obs;
  RxString emailErrorText = ''.obs;

  final mainController = Get.find<MainController>();

  final Rx<TextEditingController> userNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;

  RxBool isUserNameError = false.obs;
  RxBool isEmailError = false.obs;

  String get getTitle =>
      '${selectedPlan.platform} ${Utils.formatNumber(selectedPlan.planPrice.count)} ${selectedPlan.countInfo}';

  get getUrlTitle => selectedPlan.urlInfo;

  void expandAccountsPressed() {
    // TODO
  }

  void resetPressed() {
    userNameController.value.text = '';
    emailController.value.text = '';
  }

  Future<void> nextPressed(BuildContext context) async {
    String userName = userNameController.value.text.trim();
    String email = emailController.value.text.trim().toLowerCase();

    if (!validate(userName, email)) return;
    FocusScope.of(context).unfocus();

    mainController.isLoading = true;

    final insagramUser = await InstagramParser.fetchInstagramProfile(userName);

    if (insagramUser == null) {
      userNameErrorText.value = localization?.userNameError ??
          'Please, enter the correct username and try again';
      isUserNameError.value = true;
      mainController.isLoading = false;
    } else if (InstagramParser.isPrivateProfile(insagramUser)) {
      userNameErrorText.value = localization?.privateProfile ??
          'Please, open your profile and try again';
      isUserNameError.value = true;
      mainController.isLoading = false;
    } else {
      Get.toNamed(
        SelectedAccount.routeName,
        arguments: [
          selectedPlan.copyWith(url: userName, email: email),
          insagramUser,
        ],
      );
    }
  }

  bool validate(String userName, String email) {
    setErrorTexts();
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

  void setErrorTexts() {
    userNameErrorText.value =
        localization?.userNameWrong ?? 'Username is wrong';
    emailErrorText.value = localization?.emailWrong ?? 'Username is wrong';
  }
}
