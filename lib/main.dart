import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/services/auth.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/ui/pages/choose_posts/choose_posts.dart';
import 'package:poprey_app/ui/pages/home/home_loader.dart';
import 'package:poprey_app/ui/pages/order/order_page.dart';
import 'package:poprey_app/ui/widgets/splash_loading.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  Logger.i('[App] Starting app..');
  AppTheme.setOverlayStyle(AppTheme.primaryColor);
  WidgetsFlutterBinding.ensureInitialized();

  AppPreferences.sharedPreferences = await SharedPreferences.getInstance();

  initRoutePath = AuthService.defineInitRoutePath();

  runApp(const MyApp());
}

var initRoutePath = '/';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());
    controller.prepare();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('ru', ''),
      ],
      initialRoute: initRoutePath,
      getPages: [
        GetPage(
          name: HomeLoader.routeName,
          page: () => const HomeLoader(),
        ),
        GetPage(
          name: ChoosePosts.routeName,
          page: () => const ChoosePosts(),
        ),
        GetPage(
          name: OrderPage.routeName,
          page: () => const OrderPage(),
        ),
      ],
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: Stack(
            children: [
              if (child != null) child,
              Obx(
                () => Visibility(
                  visible: controller.preventTap,
                  child: GestureDetector(
                    onTap: () {},
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.isLoading,
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: const SplashLoadingWidget(),
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              // Obx(() => Visibility(
              //       visible: !controller.isOnlineRx.value,
              //       child: NoInternet(key: UniqueKey()),
              //     ),),
            ],
          ),
        );
      },
    );
  }
}
