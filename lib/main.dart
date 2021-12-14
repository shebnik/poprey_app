import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/services/auth.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/ui/pages/home/home.dart';
import 'package:poprey_app/ui/widgets/loading_widget.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.mapper.g.dart' show initializeJsonMapper;

void main() async {
  Logger.i('[App] Starting app..');
  WidgetsFlutterBinding.ensureInitialized();

  // final SharedPreferencesController spController =
  //     Get.put(SharedPreferencesController());

  // spController.sharedPreferences = await SharedPreferences.getInstance();

  initializeJsonMapper();

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

    return GetCupertinoApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.theme,
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
                    child: Container(
                      child: const SplashLoadingWidget(),
                      color: CupertinoColors.systemGrey.withOpacity(0.5),
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
