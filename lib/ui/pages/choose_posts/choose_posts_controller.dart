import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  PageInfo? pageInfo;

  RxBool isPostsLoading = false.obs;
  RxBool isAccountListShown = false.obs;

  RxList<InstagramPost> posts = <InstagramPost>[].obs;
  RxList<InstagramPost> selectedPosts = <InstagramPost>[].obs;

  late ScrollController choosePostsScrollController,
      accountsListScrollController;

  RxBool isBottomShadowShown = false.obs;
  RxBool isAccountsShadowShown = false.obs;

  String get count => selectedPosts.isEmpty
      ? ''
      : (selectedPlan.plan.count ~/ (selectedPosts.length)).toString();

  bool canLoadMore() =>
      MainController.isOnline &&
      !isPostsLoading.value &&
      pageInfo != null &&
      pageInfo!.hasNextPage != null &&
      pageInfo!.hasNextPage! &&
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
      try {
        if (choosePostsScrollController.offset == 0 &&
            choosePostsScrollController.position.maxScrollExtent == 0 &&
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

    choosePostsHandleScrolling();
  }

  Future<bool> loadMore({List<InstagramPost>? initialData}) async {
    if (pageInfo == null || pageInfo?.hasNextPage == false) {
      if (initialData != null) {
        posts.value = initialData;
      }
      isPostsLoading.value = false;
      return false;
    }

    isPostsLoading.value = true;
    final data =
        await InstagramParser.fetchInsagramPosts(profile.id, pageInfo!);
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
    if (isAccountListShown.value) {
      // TODO: Improve without jumping (maxscrollextent is 0.0 by default)
      accountsListScrollController.jumpTo(1);
      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
        accountsListScrollController.jumpTo(0);
      });
    }
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

  void choosePostsHandleScrolling() {
    if (choosePostsScrollController.offset >=
            choosePostsScrollController.position.maxScrollExtent &&
        canLoadMore()) {
      loadMore();
    }
    if (isPostsLoading.value) return;
    isBottomShadowShown.value =
        choosePostsScrollController.position.extentAfter < 80 && !canLoadMore()
            ? false
            : true;
  }

  bool accountsListScrollControllerNotification(
      ScrollNotification notification) {
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      isAccountsShadowShown.value =
          notification.metrics.extentAfter > 16 ? true : false;
    });
    return true;
  }
}
