import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:poprey_app/ui/pages/home/home_controller.dart';
import 'package:poprey_app/ui/pages/home/home_page.dart';
import 'package:poprey_app/ui/pages/instagram_tab/instagram_tab_controller.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab_controller.dart';

class HomeLoader extends StatelessWidget {
  static const routeName = '/';
  
  const HomeLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());

    return FutureBuilder(
      future: controller.fetchPlans(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          Get.put(InstagramTabController());
          Get.put(OtherSmTabController());
          return const HomePage();
        }
        return Container();
      },
    );
  }
}
