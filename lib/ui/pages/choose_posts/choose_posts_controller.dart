import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_post.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/app_constants.dart';

class ChoosePostsController extends GetxController {
  final mainController = Get.find<MainController>();

  late final InstagramProfilesManager profilesManager;

  late SelectedPlan selectedPlan;
  late InstagramProfile profile;
  late PageInfo pageInfo;

  RxBool isPostsLoading = true.obs;
  RxBool isAccountListShown = false.obs;

  RxList<InstagramPost> posts = <InstagramPost>[].obs;
  RxList<InstagramPost> selectedPosts = <InstagramPost>[].obs;

  late ScrollController scrollController;

  String get count => selectedPosts.isEmpty
      ? ''
      : (selectedPlan.planPrice.count ~/ (selectedPosts.length)).toString();

  bool canLoadMore() =>
      MainController.isOnline &&
      !isPostsLoading.value &&
      pageInfo.hasNextPage != null &&
      pageInfo.hasNextPage! &&
      posts.length < 48;

  ChoosePostsController() {
    profilesManager = InstagramProfilesManager();
    final args = Get.arguments as List<dynamic>;
    selectedPlan = args[0];
    initialize(args[1]);
  }

  Future<void> initialize(Map? instagramUser) async {
    profile = profilesManager.getSelectedProfile()!;

    instagramUser ??=
        await InstagramParser.fetchInstagramProfile(profile.username);
    if (instagramUser == null) return;

    var data = instagramUser['edge_owner_to_timeline_media'];
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;

    await loadMore(
      initialData: edges.map((e) => InstagramPost.fromJson(e['node'])).toList(),
    );

    while (true) {
      if (scrollController.offset == 0 &&
          scrollController.position.maxScrollExtent == 0 &&
          canLoadMore()) {
        await loadMore();
      } else {
        break;
      }
    }
  }

  Future<bool> loadMore({List<InstagramPost>? initialData}) async {
    if (pageInfo.hasNextPage == false) {
      if (initialData != null) {
        posts.value = initialData;
      }
      isPostsLoading.value = false;
      return false;
    }

    isPostsLoading.value = true;
    final data = await InstagramParser.fetchInsagramPosts(profile.id, pageInfo);
    if (data == null) {
      isPostsLoading.value = false;
      return false;
    }
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = [
      ...initialData ?? posts,
      ...edges.map((e) => InstagramPost.fromJson(e['node'])).toList(),
    ];
    isPostsLoading.value = false;
    return true;
  }

  String getPostSrc(int index) {
    return AppConstants.instagramPostUrl + posts[index].shortcode;
  }

  void postSelected(InstagramPost post) {
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

  void addAccount() {
    // Widgets.showBottomSheet(
    //   LoginSheet(
    //     controller: Get.put(
    //       LoginSheetController(
    //         selectedPlan: selectedPlan,
    //         profilesManager: profilesManager,
    //         chooseAccount: chooseAccount,
    //         profileSelected: profileSelected,
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> accountSelected(InstagramProfile profile) async {
    if (this.profile == profile) {
      toggleList();
      return;
    }
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
