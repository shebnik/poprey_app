import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:poprey_app/utils/utils.dart';

class LoginSheetController extends GetxController {
  final mainController = Get.find<MainController>();

  final SelectedPlan selectedPlan;
  final InstagramProfilesManager profilesManager;
  final VoidCallback? chooseAccount;
  final void Function(
    InstagramProfile profile,
    Map<String, dynamic>? instagramUser,
  ) profileSelected;

  LoginSheetController({
    required this.selectedPlan,
    required this.profilesManager,
    required this.profileSelected,
    this.chooseAccount,
  });

  late AppLocale appLocale;
  final Rx<TextEditingController> userNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxString userNameErrorText = ''.obs;
  RxString emailErrorText = ''.obs;
  RxBool isUserNameError = false.obs;
  RxBool isEmailError = false.obs;

  get inputType => chooseAccount != null && profilesManager.profiles.isNotEmpty
      ? InputType.account
      : null;

  String get getTitle =>
      '${selectedPlan.platform} ${Utils.formatNumber(selectedPlan.plan.count)} ${selectedPlan.countInfo}';

  get getUrlTitle => selectedPlan.urlInfo;

  Future<void> nextPressed(BuildContext context) async {
    String userName = userNameController.value.text.trim();
    String email = emailController.value.text.trim().toLowerCase();

    if (!validate(userName, email)) return;
    FocusScope.of(context).unfocus();
    if (Utils.isOnline() == false) return;

    final profile = profilesManager.getProfile(userName);
    if (profile != null) {
      profileSelected(profile, null);
      return;
    }

    toggleLoading(true);
    final instagramUser = await InstagramParser.fetchInstagramProfile(userName);

    if (instagramUser == null) {
      isUserNameError.value = true;
    } else if (InstagramParser.isPrivateProfile(instagramUser)) {
      userNameErrorText.value = appLocale.privateProfile;
      isUserNameError.value = true;
    } else {
      final profile =
          InstagramProfile.fromJson(instagramUser).copyWith(email: email);
      profileSelected(profile, instagramUser);
    }
    toggleLoading(false);
  }

  bool validate(String userName, String email) {
    userNameErrorText.value = appLocale.userNameWrong;
    emailErrorText.value = appLocale.emailWrong;
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

  void toggleLoading(bool value) {
    isLoading.value = value;
    mainController.preventTap = value;
  }
}
