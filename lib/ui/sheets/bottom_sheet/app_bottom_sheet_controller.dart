import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/ui/pages/choose_posts/choose_posts.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';

enum BottomSheetView { login, chooseAccount, autoLikes }

class AppBottomSheetController extends GetxController {
  final SelectedPlan selectedPlan;

  late final InstagramProfilesManager profilesManager;
  late final LoginSheetController loginSheetController;

  Rx<BottomSheetView> bottomSheetView = BottomSheetView.login.obs;

  get getProfiles => profilesManager.profiles;

  AppBottomSheetController(this.selectedPlan);

  @override
  void onInit() {
    super.onInit();
    profilesManager = InstagramProfilesManager();
    loginSheetController = Get.put(
      LoginSheetController(
        selectedPlan: selectedPlan,
        profilesManager: profilesManager,
        chooseAccount: chooseAccount,
        profileSelected: profileSelected,
      ),
    );
    setLoginData();
  }

  void setLoginData() {
    final selectedProfile = profilesManager.getSelectedProfile();
    if (selectedProfile != null) {
      loginSheetController.userNameController.value.text =
          selectedProfile.username;
      loginSheetController.emailController.value.text =
          selectedProfile.email ?? '';
    }
  }

  void chooseAccount() => bottomSheetView.value = BottomSheetView.chooseAccount;

  Future<void> profileSelected(
    InstagramProfile profile, [
    Map? instagramUser,
  ]) async {
    await profilesManager.selectProfile(profile);
    if (['Auto-Likes'].contains(selectedPlan.countInfo)) {
      bottomSheetView.value = BottomSheetView.autoLikes;
      return;
    }
    Get.back();
    if (['Likes', 'Views', 'Comments'].contains(selectedPlan.countInfo)) {
      Get.toNamed(
        ChoosePosts.routeName,
        arguments: [
          selectedPlan.copyWith(url: profile.username, email: profile.email),
          instagramUser,
        ],
      );
    }
  }

  void profileRemoved(InstagramProfile profile) {
    profilesManager.removeProfile(profile);
  }

  void addAccount() {
    bottomSheetView.value = BottomSheetView.login;
    loginSheetController.userNameController.value.text = '';
    loginSheetController.emailController.value.text = '';
  }
}
