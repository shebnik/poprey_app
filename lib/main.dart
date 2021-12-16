import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/services/auth.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/ui/pages/home/home.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferencesController.sharedPreferences =
      await SharedPreferences.getInstance();

  initRoutePath = AuthService.defineInitRoutePath();

  runApp(const MyApp());
}

var initRoutePath = '/';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.put(MainController());
    Get.put(SharedPreferencesController());
    controller.prepare();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.materialThemeData(),
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
          name: Home.routeName,
          page: () => const Home(),
        ),
        GetPage(
          name: SelectedAccount.routeName,
          page: () => const SelectedAccount(),
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
                  child: GestureDetector(
                    onTap: () {},
                    child: Material(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: const SplashLoadingWidget(),
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  visible: controller.isLoading,
                ),
              ),
              // Obx(() => Visibility(
              //       child: NoInternet(key: UniqueKey()),
              //       visible: !controller.isOnline,
              //     ),),
            ],
          ),
        );
      },
    );
  }
}
