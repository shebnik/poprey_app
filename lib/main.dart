import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/pages/additional_plans.dart';
import 'package:poprey_app/pages/instagram_plans.dart';
import 'package:poprey_app/utils/app_colors.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() async {
  Logger.i('[App] Starting app..');
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);

  await checkConnectivity();

  runApp(const MyApp());
}

Future<bool> checkConnectivity() async {
  final _connectivityResult = await Connectivity().checkConnectivity();
  Logger.i(_connectivityResult);
  return _connectivityResult != ConnectivityResult.none ? true : false;
}

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
    _connectivityListener = Connectivity().onConnectivityChanged.listen((
        ConnectivityResult result) {
      Logger.i(result);
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
      home: Scaffold(
        body: Center(
          child: InstagramPlans(),
        ),
      ),
    );
  }
}
