import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/services/app_preferences.dart';

class InstagramProfilesManager {
  List<InstagramProfile> profiles = [];

  InstagramProfilesManager() {
    profiles = AppPreferences.getInstagramProfiles() ?? [];
    profiles.sort((key1, key2) => key1.isSelected == true ? -1 : 1);
  }

  Future<void> selectProfile(InstagramProfile profile) async {
    final foundProfiles = profiles.where((element) => element.id == profile.id);
    if (foundProfiles.isNotEmpty) {
      if (foundProfiles.first.isSelected ?? false) {
        return;
      }
      profiles.remove(foundProfiles.first);
    }

    profiles = profiles.map((e) => e.copyWith(isSelected: false)).toList();
    profiles.insert(
      0,
      profile.copyWith(isSelected: true),
    );

    await AppPreferences.setInstagramProfiles(profiles);
  }

  InstagramProfile? getSelectedProfile() {
    final foundProfiles = profiles.where((e) => e.isSelected == true);
    if (foundProfiles.isNotEmpty) return foundProfiles.first;
  }

  bool isProfileExists(String userName) {
    return profiles.where((e) => e.username == userName).isNotEmpty;
  }
}
