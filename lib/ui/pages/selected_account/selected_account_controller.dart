import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/insagram_post.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/utils/app_constants.dart';

class SelectedAccountController extends GetxController {
  final mainController = Get.find<MainController>();

  late final InstagramProfilesManager profilesManager;

  late SelectedPlan selectedPlan;
  late InstagramProfile profile;
  late PageInfo pageInfo;

  RxBool isPostsLoading = true.obs;
  RxBool isAccountListShown = false.obs;

  RxList<InsagramPost> posts = <InsagramPost>[].obs;
  RxList<InsagramPost> selectedPosts = <InsagramPost>[].obs;

  String get count => selectedPosts.isEmpty
      ? ''
      : (selectedPlan.planPrice.count ~/ (selectedPosts.length)).toString();

  SelectedAccountController() {
    profilesManager = InstagramProfilesManager();
    final args = Get.arguments as List<dynamic>;
    selectedPlan = args[0];
    initialize(args[1]);
  }

  Future<void> initialize(Map instagramUser) async {
    profile = profilesManager.getSelectedProfile()!;

    var data = instagramUser['edge_owner_to_timeline_media'];
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = edges.map((e) => InsagramPost.fromJson(e['node'])).toList();

    await loadMore();
  }

  Future<bool> loadMore() async {
    if (pageInfo.hasNextPage == false) return false;

    isPostsLoading.value = true;
    final data = await InstagramParser.fetchInsagramPosts(profile.id, pageInfo);
    if (data == null) {
      isPostsLoading.value = false;
      return false;
    }
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = [
      ...posts,
      ...edges.map((e) => InsagramPost.fromJson(e['node'])).toList(),
    ];
    isPostsLoading.value = false;
    return true;
  }

  String getPostSrc(int index) {
    return AppConstants.instagramPostUrl + posts[index].shortcode;
  }

  void postSelected(InsagramPost post) {
    if (selectedPosts.contains(post)) {
      selectedPosts.remove(post);
    } else {
      selectedPosts.add(post);
    }
  }

  void resetPressed() {
    selectedPosts.value = [];
  }

  void nextPressed(BuildContext context) {
    // TODO
  }

  void toggleList() {
    isAccountListShown.value = !isAccountListShown.value;
  }

  int getAccountListCount() {
    return isAccountListShown.value ? profilesManager.profiles.length : 1;
  }

  void addAccount() {}

  Future<void> accountSelected(InstagramProfile profile) async {
    if (this.profile == profile) return;
    await profilesManager.selectProfile(profile);
    isAccountListShown.value = false;
    posts.clear();
    selectedPosts.clear();
    isPostsLoading.value = true;
    profile = profilesManager.getSelectedProfile()!;
    await initialize(
        (await InstagramParser.fetchInstagramProfile(profile.username))!);
  }
}
