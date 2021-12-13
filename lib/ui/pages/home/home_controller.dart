import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late CupertinoTabController cupertinoTabController;
  var selectedTab = RxInt(0);

  @override
  void onInit() {
    super.onInit();
    cupertinoTabController = CupertinoTabController();
  }

  void onTabBarTap(int value) {
    selectedTab.value = value;
  }
}
