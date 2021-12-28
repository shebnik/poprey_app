import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/services/sm_parser.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:poprey_app/utils/utils.dart';

class LoginSheetController extends GetxController {
  final mainController = Get.find<MainController>();

  final SelectedPlan selectedPlan;
  final bool isInstagram;
  final InstagramProfilesManager profilesManager;
  final VoidCallback? chooseAccount;
  final void Function(
    InstagramProfile profile,
    Map<String, dynamic>? instagramUser,
  ) profileSelected;
  final void Function(SelectedPlan plan, SmUrlModel model) linkSelected;

  LoginSheetController({
    required this.selectedPlan,
    required this.profilesManager,
    required this.profileSelected,
    required this.linkSelected,
    this.chooseAccount,
  }) : isInstagram = selectedPlan.platform == 'Instagram';

  late AppLocale appLocale;
  final Rx<TextEditingController> firstInputController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController = TextEditingController().obs;

  RxBool isLoading = false.obs;
  RxString userNameErrorText = ''.obs;
  RxString emailErrorText = ''.obs;
  RxBool isFirstInputError = false.obs;
  RxBool isEmailError = false.obs;

  get inputType => chooseAccount != null && profilesManager.profiles.isNotEmpty
      ? InputType.account
      : null;

  String get getTitle =>
      '${selectedPlan.platform} ${Utils.formatNumber(selectedPlan.plan.count)} ${selectedPlan.countInfo}';

  get getUrlTitle => selectedPlan.urlInfo;

  Future<void> nextPressed(BuildContext context) async {
    String firstInput = firstInputController.value.text.trim();
    String email = emailController.value.text.trim().toLowerCase();

    if (!validate(firstInput, email)) return;
    FocusScope.of(context).unfocus();
    if (Utils.isOnline() == false) return;

    if (isInstagram) {
      final profile = profilesManager.getProfile(firstInput);
      if (profile != null) {
        profileSelected(profile, null);
        return;
      }

      toggleLoading(true);
      final instagramUser =
          await InstagramParser.fetchInstagramProfile(firstInput);

      if (instagramUser == null) {
        isFirstInputError.value = true;
      } else if (InstagramParser.isPrivateProfile(instagramUser)) {
        userNameErrorText.value = appLocale.privateProfile;
        isFirstInputError.value = true;
      } else {
        final profile =
            InstagramProfile.fromJson(instagramUser).copyWith(email: email);
        profileSelected(profile, instagramUser);
      }
    } else {
      toggleLoading(true);
      final model = await SmParser.fetchUrl(firstInput, selectedPlan);
      if (model == null) {
        isFirstInputError.value = true;
      } else {
        AppPreferences.setUserEmail(email);
        linkSelected(
            selectedPlan.copyWith(url: firstInput, email: email), model);
      }
    }
    toggleLoading(false);
  }

  bool validate(String firstInput, String email) {
    userNameErrorText.value =
        isInstagram ? appLocale.userNameWrong : appLocale.urlWrong;
    emailErrorText.value = appLocale.emailWrong;
    if (isInstagram ? !GetUtils.isUsername(firstInput) : false) {
      //!GetUtils.isURL(firstInput)) {
      isFirstInputError.value = true;
      return false;
    } else {
      isFirstInputError.value = false;
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
