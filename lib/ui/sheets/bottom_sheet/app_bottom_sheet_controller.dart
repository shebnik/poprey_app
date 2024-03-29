import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/services/sm_parser.dart';
import 'package:poprey_app/ui/pages/order/instagram/instagram_order_page.dart';
import 'package:poprey_app/ui/pages/order/other_sm/other_sm_order.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';

enum BottomSheetView { login, chooseAccount, autoLikes }

class AppBottomSheetController extends GetxController {
  final SelectedPlan selectedPlan;
  late bool isInstagram;

  late final InstagramProfilesManager profilesManager;
  late final LoginSheetController loginSheetController;

  Rx<BottomSheetView> bottomSheetView = BottomSheetView.login.obs;

  get getProfiles => profilesManager.profiles;

  AppBottomSheetController(this.selectedPlan) {
    isInstagram = selectedPlan.platform == 'Instagram';
    profilesManager = InstagramProfilesManager();
    loginSheetController = LoginSheetController(
      selectedPlan: selectedPlan,
      profilesManager: profilesManager,
      chooseAccount: isInstagram ? showChooseAccount : null,
      profileSelected: profileSelected,
      linkSelected: linkSelected,
    );
    setLoginData();
  }

  void setLoginData() {
    if (!isInstagram) {
      loginSheetController.emailController.value.text =
          AppPreferences.getUserEmail() ?? '';
      return;
    }
    // if (showChooseAccount == null) {
    //   loginSheetController.firstInputController.value.text = '';
    //   loginSheetController.emailController.value.text = '';
    //   return;
    // }
    final selectedProfile = profilesManager.getSelectedProfile();
    if (selectedProfile != null) {
      loginSheetController.firstInputController.value.text =
          selectedProfile.username ?? '';
      loginSheetController.emailController.value.text =
          selectedProfile.email ?? '';
    }
  }

  void showChooseAccount() => bottomSheetView.value = BottomSheetView.chooseAccount;

  Future<void> profileSelected(
    InstagramProfile profile, [
    Map? instagramUser,
  ]) async {
    profilesManager.selectProfile(profile);
    if (['Auto-Likes'].contains(selectedPlan.countInfo)) {
      bottomSheetView.value = BottomSheetView.autoLikes;
      return;
    }
    Get.back();
    if (['Likes', 'Views', 'Comments'].contains(selectedPlan.countInfo)) {
      Get.toNamed(
        SelectedAccount.routeName,
        arguments: [
          selectedPlan.copyWith(url: profile.username, email: profile.email),
          instagramUser,
        ],
      );
    } else {
      showOrderPage(selectedPlan);
    }
  }

  void linkSelected(SelectedPlan plan, SmUrlModel model) {
    Get.back();
    Get.toNamed(OtherSmOrder.routeName, arguments: [plan, model]);
  }

  Future<void> profileRemoved(InstagramProfile profile) async {
    await profilesManager.removeProfile(profile);
    if (profilesManager.profiles.isEmpty) {
      bottomSheetView.value = BottomSheetView.login;
      loginSheetController.firstInputController.value.text = '';
      loginSheetController.emailController.value.text = '';
    }
  }

  void addAccount() {
    bottomSheetView.value = BottomSheetView.login;
    loginSheetController.firstInputController.value.text = '';
    loginSheetController.emailController.value.text = '';
  }

  void showLogin() => bottomSheetView.value = BottomSheetView.login;

  void showOrderPage(SelectedPlan plan) {
    Get.back();
    Get.toNamed(InstagramOrderPage.routeName, arguments: [plan]);
  }
}
