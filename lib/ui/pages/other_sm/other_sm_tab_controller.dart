import 'package:get/state_manager.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';

class OtherSmTabController extends GetxController {
  late SMPlansModel smPLansModel;

  Rx<List<SelectionSliderModel>> selectionSliderModel = Rx([]);

  RxInt selectedIndex = 0.obs;

  void onSelected(int index) {
    if (index == selectedIndex.value) return;
    selectedIndex.value = index;
    updateList();
  }

  void setModel(SMPlansModel model) {
    smPLansModel = model;
    updateList();
  }

  void updateList() {
    switch (selectedIndex.value) {
      case 0:
        // All
        selectionSliderModel.value = _all;
        break;
      case 1:
        // YouTube
        selectionSliderModel.value = _youTube;
        break;
      case 2:
        // TikTok
        selectionSliderModel.value = _tikTok;
        break;
      case 3:
        // Facebook
        selectionSliderModel.value = _facebook;
        break;
      case 4:
        // Spotify
        selectionSliderModel.value = _spotify;
        break;
      case 5:
        // Twitter
        selectionSliderModel.value = _twitter;
        break;
      case 6:
        // VK
        selectionSliderModel.value = _vk;
        break;
    }
  }

  List<SelectionSliderModel> get _all =>
      [..._youTube, ..._tikTok, ..._facebook, ..._spotify, ..._twitter, ..._vk];

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
