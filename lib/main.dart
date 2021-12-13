import 'package:flutter/cupertino.dart';
import 'package:poprey_app/main_controller.dart';
import 'package:poprey_app/services/auth.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/ui/widgets/loading_widget.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Logger.i('[App] Starting app..');
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferencesService.sharedPreferences =
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
    controller.prepare();

    return GetCupertinoApp(
      title: AppConstants.appName,
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      initialRoute: initRoutePath,
      getPages: [
        GetPage(
          name: Start.routeName,
          page: () => const Start(),
        ),
        GetPage(
          name: CreateAccount.routeName,
          page: () => const CreateAccount(),
        ),
        GetPage(
          name: Login.routeName,
          page: () => const Login(),
        ),
        GetPage(
          name: ResetPassword.routeName,
          page: () => const ResetPassword(),
        ),
        GetPage(
          name: LoadDashboard.routeName,
          page: () => const LoadDashboard(),
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
                      child: const LoadingWidget(),
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
