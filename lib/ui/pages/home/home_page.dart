import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/home/app_navigation_bar.dart';
import 'package:poprey_app/ui/pages/home/home_page_controller.dart';
import 'package:poprey_app/ui/pages/instagram_tab/instagram_tab.dart';
import 'package:poprey_app/ui/pages/instagram_tab/instagram_tab_controller.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab_controller.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController controller;
  late InstagramTabController instagramTabController;
  late OtherSmTabController otherSmTabController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomePageController());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchPlans(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          instagramTabController = Get.put(InstagramTabController());
          otherSmTabController = Get.put(OtherSmTabController());
          return homeTabs();
        }
        return Container();
      },
    );
  }

  Widget homeTabs() {
    return CupertinoTabScaffold(
      controller: controller.cupertinoTabController,
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            if (index == 1) {
              return tabPage(
                const OtherSmTab(),
                false,
              );
            }
            return tabPage(const InstagramTab());
          },
        );
      },
      tabBar: CupertinoTabBar(
        onTap: controller.onTabBarTap,
        backgroundColor: AppTheme.primary,
        items: [
          tabItem(0, AppConstants.Instagram, AppAssets.instagram),
          tabItem(1, AppLocalizations.of(context)!.otherSM, AppAssets.otherSm),
        ],
      ),
    );
  }

  Widget tabPage(Widget tab, [bool applyElevation = true]) {
    return Scaffold(
      appBar: HomeNavigationBar(applyElevation: applyElevation),
      body: SafeArea(
        child: tab,
      ),
    );
  }

  BottomNavigationBarItem tabItem(int index, String title, String imageAsset) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 7.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => SvgPicture.asset(
                imageAsset,
                color: controller.selectedTab.value == index
                    ? AppTheme.primaryBlue
                    : null,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: AppConstants.SFProText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}