import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class BottomSheetController extends GetxController {
  final Rx<TextEditingController> userNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> emailController =
      TextEditingController().obs;
}
