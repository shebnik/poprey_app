import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/services/shared_preferences.dart';

class InstagramProfilesManager {
  late List<InstagramProfile> profiles;

  InstagramProfilesManager() {
    profiles = SharedPreferencesController.getInstagramProfiles() ?? [];
    profiles.sort((key1, key2) => key1.isSelected == true ? 1 : -1);
  }

  Future<void> selectProfile(InstagramProfile profile) async {
    final foundProfiles = profiles.where((element) => element.id == profile.id);
    if (foundProfiles.isNotEmpty) {
      if (foundProfiles.first.isSelected) {
        return;
      }
      profiles.remove(foundProfiles.first);
    }

    profiles = profiles.map((e) => e.copyWith(isSelected: false)).toList();
    profiles.insert(
      0,
      profile.copyWith(isSelected: true),
    );
    
    await SharedPreferencesController.setInstagramProfiles(profiles);
  }
}
