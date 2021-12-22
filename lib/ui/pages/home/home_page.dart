import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/home/home_app_bar.dart';
import 'package:poprey_app/ui/pages/instagram_tab/instagram_tab.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class TabItem {
  int index;
  String title;
  String iconAsset;

  TabItem({
    required this.index,
    required this.title,
    required this.iconAsset,
  });
}

final List<TabItem> tabBar = [
  TabItem(
      index: 0, title: AppConstants.Instagram, iconAsset: AppAssets.instagram),
  TabItem(index: 1, title: AppConstants.OtherSM, iconAsset: AppAssets.otherSm),
];

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  RxInt currentTabIndex = RxInt(0);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabBar.length, vsync: this);
    tabController.addListener(() {
      currentTabIndex.value = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: TabBarView(
          key: UniqueKey(),
          controller: tabController,
          children: const [
            InstagramTab(),
            OtherSmTab(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            tabController.index = index;
            currentTabIndex.value = index;
          },
          currentIndex: currentTabIndex.value,
          backgroundColor: AppTheme.primary,
          iconSize: 20,
          selectedFontSize: 10,
          selectedItemColor: AppTheme.primaryBlue,
          unselectedFontSize: 10,
          unselectedItemColor: const Color(0xFF586F88),
          type: BottomNavigationBarType.fixed,
          items: [for (final item in tabBar) tabItem(item)],
        ),
      ),
    );
  }

  BottomNavigationBarItem tabItem(TabItem item) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset(
          item.iconAsset,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset(
          item.iconAsset,
          color: AppTheme.primaryBlue,
        ),
      ),
      label: item.title,
      tooltip: item.title,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
