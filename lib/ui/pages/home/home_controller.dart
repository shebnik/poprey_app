import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/plans_parser.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find();

  late CupertinoTabController cupertinoTabController;
  var selectedTab = RxInt(0);

  Rx<InstagramModel?> instagramModel = InstagramModel.fromJson(null).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    cupertinoTabController = CupertinoTabController();
    instagramModel.value = InstagramModel.fromJson(
      await PlansParser.getInstaPlans(),
    );
    mainController.isLoading = false;
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }
}
