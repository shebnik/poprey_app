import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poprey_app/assets/assets.dart';
import 'package:poprey_app/pages/additional_plans.dart';
import 'package:poprey_app/pages/instagram_images.dart';
import 'package:poprey_app/services/preferences.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:poprey_app/utils/ui.dart';
import 'package:provider/provider.dart';

import 'instagram_plans.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int pageNumber;

  @override
  void initState() {
    super.initState();
    pageNumber = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    pageNumber = 0;
                  }),
                  icon: SvgPicture.asset(
                    Assets.instagram,
                    width: 60,
                    height: 60,
                  ),
                ),
                UI.spacer(),
                IconButton(
                  onPressed: () => setState(() {
                    pageNumber = 1;
                  }),
                  icon: SvgPicture.asset(
                    Assets.additionalServices,
                    width: 60,
                    height: 60,
                  ),
                ),
              ],
            ),
            if (pageNumber == 0) InstagramPlans(),
            if (pageNumber == 1) AdditionalPlans(),
          ],
        ),
        // child: Consumer<PreferencesService>(
        //   builder: (context, value, child) {
        //     if (value.connectionAvailable) {
        //       return InstagramPlans();
        //     } else {
        //       return UI.loading;
        //     }
        //   },
        // ),
      ),
    );
  }
}
