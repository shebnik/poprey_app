import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/pages/home.dart';
import 'package:poprey_app/services/preferences.dart';
import 'package:poprey_app/utils/app_colors.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() async {
  Logger.i('[App] Starting app..');
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (context) => PreferencesService(prefs),
      child: MyApp(),
    ),
  );
}
//
// Future<bool> checkConnectivity() async {
//   return await Connectivity().checkConnectivity() != ConnectivityResult.none
//       ? true
//       : false;
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _connectivityListener;

  @override
  void initState() {
    super.initState();

    final prefs = Provider.of<PreferencesService>(context, listen: false);
    Get.put(prefs);

    _connectivityListener = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      prefs.connectionAvailable =
          result != ConnectivityResult.none ? true : false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _connectivityListener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poprey',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
