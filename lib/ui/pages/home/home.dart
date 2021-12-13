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
import 'package:poprey_app/utils/hex_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return CupertinoPageScaffold(
      navigationBar: const AppNavigationBar(),
      backgroundColor: HexColor.fromHex('#E5E5E5'),
      child: CupertinoTabScaffold(
        controller: controller.cupertinoTabController,
        tabBar: CupertinoTabBar(
          onTap: controller.onTabBarTap,
          backgroundColor: AppTheme.primary,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 7.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => SvgPicture.asset(
                        AppAssets.instagram,
                        color: controller.selectedTab.value == 0
                            ? AppTheme.secondary
                            : null,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      AppConstants.instagram,
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 7.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(
                      () => SvgPicture.asset(
                        AppAssets.otherSm,
                        color: controller.selectedTab.value == 1
                            ? AppTheme.secondary
                            : null,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppLocalizations.of(context)!.otherSM,
                      style: const TextStyle(
                        fontSize: 10,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        tabBuilder: (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Obx(
                    () => InstagramTab(
                      instagramModel: controller.instagramModel.value,
                    ),
                  ),
                );
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  child: OtherSmTab(),
                );
              });
              break;
          }
          return returnValue;
        },
      ),
    );
    // return SafeArea(
    //   child: CupertinoPageScaffold(
    //     child: Container(),
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             GestureDetector(
    //               onTap: () => setState(() {
    //                 pageNumber = 0;
    //               }),
    //               child: SvgPicture.asset(
    //                 AppAssets.instagram,
    //                 width: 60,
    //                 height: 60,
    //               ),
    //             ),
    //             const SizedBox(height: 16),
    //             GestureDetector(
    //               onTap: () => setState(() {
    //                 pageNumber = 1;
    //               }),
    //               child: SvgPicture.asset(
    //                 AppAssets.additionalServices,
    //                 width: 60,
    //                 height: 60,
    //               ),
    //             ),
    //           ],
    //         ),
    //         if (pageNumber == 0) const InstagramPlans(),
    //         if (pageNumber == 1) const AdditionalPlans(),
    //       ],
    //     ),
    //     child: Consumer<PreferencesService>(
    //       builder: (context, value, child) {
    //         if (value.connectionAvailable) {
    //           return InstagramPlans();
    //         } else {
    //           return UI.loading;
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}
