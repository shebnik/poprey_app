import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/services/app_preferences.dart';

class InstagramProfilesManager extends GetxController {
  RxList<InstagramProfile> profiles = <InstagramProfile>[].obs;

  InstagramProfilesManager() {
    profiles.value = AppPreferences.getInstagramProfiles() ?? [];
    profiles.sort((key1, key2) => key1.isSelected == true ? -1 : 1);
  }

  Future<InstagramProfile?> selectProfile(InstagramProfile profile) async {
    final foundProfiles = profiles.where((element) => element.id == profile.id);
    if (foundProfiles.isNotEmpty) {
      if (foundProfiles.first.isSelected ?? false) {
        return null;
      }
      profiles.remove(foundProfiles.first);
    }

    profiles.value =
        profiles.map((e) => e.copyWith(isSelected: false)).toList();
    final newProfile = profile.copyWith(isSelected: true);
    profiles.insert(
      0,
      newProfile,
    );
    await AppPreferences.setInstagramProfiles(profiles);
    return newProfile;
  }

  InstagramProfile? getSelectedProfile() {
    final foundProfiles = profiles.where((e) => e.isSelected == true);
    if (foundProfiles.isNotEmpty) return foundProfiles.first;
  }

  InstagramProfile? getProfile(String userName) {
    final foundProfiles = profiles.where((e) => e.username == userName);
    if (foundProfiles.isNotEmpty) return foundProfiles.first;
  }

  Future<void> removeProfile(InstagramProfile profile) async {
    profiles.remove(profile);
    if (profile.isSelected != null &&
        profile.isSelected == true &&
        profiles.isNotEmpty) {
      profiles[0] = profiles.first.copyWith(isSelected: true);
    }
    await AppPreferences.setInstagramProfiles(profiles);
  }
}
