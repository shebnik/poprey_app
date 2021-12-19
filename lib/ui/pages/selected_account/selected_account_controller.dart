import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/insagram_post.dart';
import 'package:poprey_app/models/instagram_profile.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';
import 'package:poprey_app/utils/app_constants.dart';

class SelectedAccountController extends GetxController {
  final SelectedPlan selectedPlan;
  final Map<String, dynamic> instagramUser;

  final mainController = Get.find<MainController>();

  late InstagramProfile profile;
  late PageInfo pageInfo;

  RxList<InsagramPost> posts = <InsagramPost>[].obs;
  RxList<InsagramPost> selectedPosts = <InsagramPost>[].obs;

  SelectedAccountController(this.selectedPlan, this.instagramUser) {
    profile = InstagramProfile.fromJson(instagramUser);
    
    var data = instagramUser['edge_owner_to_timeline_media'];
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = edges.map((e) => InsagramPost.fromJson(e['node'])).toList();
  }

  String get count => selectedPosts.isEmpty
      ? ''
      : (selectedPlan.planPrice.count ~/ (selectedPosts.length)).toString();

  @override
  void onInit() async {
    super.onInit();
    await loadMore();
    mainController.isLoading = false;
  }

  Future<bool> loadMore() async {
    if (pageInfo.hasNextPage == false) return false;
    final data = await InstagramParser.fetchInsagramPosts(profile.id, pageInfo);
    if (data == null) return false;
    pageInfo = PageInfo.fromJson(data['page_info']);

    final edges = data['edges'] as List<dynamic>;
    posts.value = [
      ...posts,
      ...edges.map((e) => InsagramPost.fromJson(e['node'])).toList(),
    ];
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
}
