import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_post.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/services/instagram_profile_manager.dart';
import 'package:poprey_app/ui/pages/order/instagram/instagram_order_page.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/app_widgets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/logger.dart';

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
      : (selectedPlan.plan.count ~/ (selectedPosts.length)).toString();

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
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    final args = Get.arguments as List<dynamic>;
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
      try {
        if (scrollController.offset == 0 &&
            scrollController.position.maxScrollExtent == 0 &&
            canLoadMore()) {
          await loadMore();
        } else {
          break;
        }
      } catch (e) {
        Logger.e('[ChoosePostsController] scrollController error', e);
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
    if (selectedPosts.isEmpty) {
      AppWidgets.openSnackbar(message: 'Please choose at least 1 post');
      return;
    }
    Get.toNamed(
      InstagramOrderPage.routeName,
      arguments: [selectedPlan, selectedPosts],
    );
  }

  void toggleList() {
    isAccountListShown.value = !isAccountListShown.value;
  }

  int getAccountListCount() {
    return isAccountListShown.value ? profilesManager.profiles.length : 1;
  }

  void addAccount(BuildContext context) {
    AppWidgets.showBottomSheet(
      context,
      LoginSheet(
        controller: LoginSheetController(
          selectedPlan: selectedPlan,
          profilesManager: profilesManager,
          profileSelected: profileSelected,
          linkSelected: (a, b) => {},
        ),
      ),
    );
  }

  void clearView(InstagramProfile profile) async {
    if (this.profile == profile) {
      toggleList();
      return;
    }
    isAccountListShown.value = false;
    posts.clear();
    selectedPosts.clear();
    isPostsLoading.value = true;
  }

  Future<void> accountSelected(InstagramProfile profile) async {
    clearView(profile);
    await profilesManager.selectProfile(profile);
    await initialize(
        (await InstagramParser.fetchInstagramProfile(profile.username))!);
  }

  Future<void> profileSelected(
      InstagramProfile profile, Map<String, dynamic>? instagramUser) async {
    clearView(profile);
    Get.back();
    await profilesManager.selectProfile(profile);
    await initialize(instagramUser ??
        (await InstagramParser.fetchInstagramProfile(profile.username))!);
  }
}
