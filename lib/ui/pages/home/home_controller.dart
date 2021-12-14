import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/plans_parser.dart';

class HomeController extends GetxController {
  final MainController mainController = Get.find();

  late CupertinoTabController cupertinoTabController;
  var selectedTab = RxInt(0);

  @override
  Future<void> onInit() async {
    super.onInit();
    cupertinoTabController = CupertinoTabController();
    final instagramModel = JsonMapper.deserialize<InstagramModel>(
      await PlansParser.getInstaPlans(),
    );
    print(instagramModel.toString());
    mainController.isLoading = false;
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }
}
