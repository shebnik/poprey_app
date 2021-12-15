import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab_controller.dart';
import 'other_sm_selection_list.dart';

class OtherSmTab extends StatefulWidget {
  const OtherSmTab({Key? key}) : super(key: key);

  @override
  _OtherSmTabState createState() => _OtherSmTabState();
}

class _OtherSmTabState extends State<OtherSmTab> {
  late OtherSmTabController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OtherSmTabController());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OtherSMSelectionList(controller: controller),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(),
          ),
        ),
      ],
    );
  }
}
