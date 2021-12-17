import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/insagram_post.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/utils.dart';

class SelectedAccountController extends GetxController {
  final SelectedPlan selectedPlan;

  SelectedAccountController(this.selectedPlan);

  final mainController = Get.find<MainController>();

  late InstagramProfile profile;
  late PageInfo pageInfo;

  late RxList<InsagramPost> posts = <InsagramPost>[].obs;
  late RxList<InsagramPost> selectedPosts = <InsagramPost>[].obs;

  // late ScrollController scrollController;

  String get count => selectedPlan.planPrice.count.toString();

  @override
  void onReady() {
    super.onReady();
    // scrollController = ScrollController()..addListener(_scrollListener);
  }

  // void _scrollListener() async {
  //   print(scrollController.position.maxScrollExtent);
  //   print(scrollController.offset);
  //   if (scrollController.position.maxScrollExtent == scrollController.offset) {
  //     if (pageInfo.hasNextPage) await loadMore();
  //   }
  // }

  Future<bool> init() async {
    final insagramUser =
        await InstagramParser.fetchInstagramProfile(selectedPlan.url!);

    if (insagramUser == null) {
      mainController.isLoading = false;
      Get.back();
      return false;
    }
    setProfile(insagramUser);
    await loadMore();
    mainController.isLoading = false;
    return true;
  }

  void setProfile(Map<String, dynamic> insagramUser) {
    profile = InstagramProfile.fromJson(insagramUser);
    var data = insagramUser['edge_owner_to_timeline_media'];
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = edges.map((e) => InsagramPost.fromJson(e['node'])).toList();
  }

  Future<void> loadMore() async {
    if (pageInfo.hasNextPage == false) return;
    final data = await InstagramParser.fetchInsagramPosts(profile.id, pageInfo);
    if (data == null) return;
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = [
      ...posts,
      ...edges.map((e) => InsagramPost.fromJson(e['node'])).toList(),
    ];
  }

  String getPostSrc(int index) {
    return AppConstants.instagramPostUrl + posts[index].shortcode;
  }

  String get getFollowers =>
      '${Utils.formatNumber(profile.followers)} followers';

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
}
