import 'package:get/state_manager.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';

class OtherSmTabController extends GetxController {
  late SMPlansModel smPLansModel;

  Rx<List<SelectionSliderModel>> slidersList = Rx([]);

  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    smPLansModel = AppPreferences.getSMPlansModel()!;
    updateList();
  }

  void onSelected(int index) {
    if (index == selectedIndex.value) return;
    selectedIndex.value = index;
    updateList();
  }

  void updateList() {
    switch (selectedIndex.value) {
      case 0:
        // All
        slidersList.value = _all;
        break;
      case 1:
        // YouTube
        slidersList.value = _youTube;
        break;
      case 2:
        // TikTok
        slidersList.value = _tikTok;
        break;
      case 3:
        // Facebook
        slidersList.value = _facebook;
        break;
      case 4:
        // Spotify
        slidersList.value = _spotify;
        break;
      case 5:
        // Twitter
        slidersList.value = _twitter;
        break;
      case 6:
        // VK
        slidersList.value = _vk;
        break;
    }
  }

  List<SelectionSliderModel> get _all => [
        ..._youTube,
        ..._tikTok,
        ..._facebook,
        ..._spotify,
        ..._twitter,
        ..._vk,
      ];

  List<SelectionSliderModel> get _youTube => smPLansModel.youtube.entries
      .map((e) => SelectionSliderModel.fromMap(
            platform: AppConstants.YouTube,
            countInfo: e.value.countInfo,
            urlInfo: e.value.urlInfo,
            plans: e.value.plans,
            imageAsset: AppAssets.youtube,
          ))
      .toList();

  List<SelectionSliderModel> get _tikTok => smPLansModel.tiktok.entries
      .map((e) => SelectionSliderModel.fromMap(
            platform: AppConstants.TikTok,
            countInfo: e.value.countInfo,
            urlInfo: e.value.urlInfo,
            plans: e.value.plans,
            imageAsset: AppAssets.tiktok,
          ))
      .toList();

  List<SelectionSliderModel> get _facebook => smPLansModel.facebook.entries
      .map((e) => SelectionSliderModel.fromMap(
            platform: AppConstants.Facebook,
            countInfo: e.value.countInfo,
            urlInfo: e.value.urlInfo,
            plans: e.value.plans,
            imageAsset: AppAssets.facebook,
          ))
      .toList();

  List<SelectionSliderModel> get _spotify => smPLansModel.spotify.entries
      .map((e) => SelectionSliderModel.fromMap(
            platform: AppConstants.Spotify,
            countInfo: e.value.countInfo,
            urlInfo: e.value.urlInfo,
            plans: e.value.plans,
            imageAsset: AppAssets.spotify,
          ))
      .toList();

  List<SelectionSliderModel> get _twitter => smPLansModel.twitter.entries
      .map((e) => SelectionSliderModel.fromMap(
            platform: AppConstants.Twitter,
            countInfo: e.value.countInfo,
            urlInfo: e.value.urlInfo,
            plans: e.value.plans,
            imageAsset: AppAssets.twitter,
          ))
      .toList();

  List<SelectionSliderModel> get _vk => smPLansModel.vk.entries
      .map((e) => SelectionSliderModel.fromMap(
            platform: AppConstants.VK,
            countInfo: e.value.countInfo,
            urlInfo: e.value.urlInfo,
            plans: e.value.plans,
            imageAsset: AppAssets.vk,
          ))
      .toList();
}
