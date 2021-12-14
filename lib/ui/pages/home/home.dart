import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/home/app_navigation_bar.dart';
import 'package:poprey_app/ui/pages/home/home_controller.dart';
import 'package:poprey_app/ui/pages/instagram/instagram_tab.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Nav {
  final String title;
  final Widget icon;

  Nav({required this.title, required this.icon});
}

class Home extends StatefulWidget {
  static const routeName = '/';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: controller.cupertinoTabController,
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            if (index == 1) {
              return tabPage(const OtherSmTab());
            }
            return tabPage(const InstagramTab());
          },
        );
      },
      tabBar: CupertinoTabBar(
        onTap: controller.onTabBarTap,
        backgroundColor: AppTheme.primary,
        items: [
          tabItem(0, AppConstants.instagram, AppAssets.instagram),
          tabItem(1, AppLocalizations.of(context)!.otherSM, AppAssets.otherSm),
        ],
      ),
    );
  }

  Widget tabPage(Widget tab) {
    return CupertinoPageScaffold(
      navigationBar: const HomeNavigationBar(),
      child: SafeArea(
        child: CupertinoScrollbar(
          isAlwaysShown: false,
          thickness: 5,
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
              child: tab,
            ),
          ),
        ),
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
                    ? AppTheme.secondary
                    : null,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'SF Pro Text',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
