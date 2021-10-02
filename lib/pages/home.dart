import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //child: InstagramPlans(),
        child: Consumer<PreferencesService>(
          builder: (context, value, child) {
            if (value.connectionAvailable) {
              return InstagramPlans();
            } else {
              return UI.loading;
            }
          },
        ),
      ),
    );
  }
}
