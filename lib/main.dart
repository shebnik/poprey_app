import 'package:flutter/material.dart';
import 'package:poprey_app/pages/additional_plans.dart';
import 'package:poprey_app/pages/instagram_plans.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

void main() async {
  Logger.i('[App] Starting app..');

  runApp(const MyApp());

  final prefs = await SharedPreferences.getInstance();
  Get.put(prefs);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poprey',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Row(
            children: [
              InstagramPlans(),
              AdditionalPlans(),
            ],
          ),
        ),
      ),
    );
  }
}
