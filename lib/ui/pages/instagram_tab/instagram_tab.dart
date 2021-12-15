import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/ui/pages/instagram_tab/instagram_tab_controller.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider.dart';

class InstagramTab extends StatefulWidget {
  const InstagramTab({Key? key}) : super(key: key);

  @override
  _InstagramTabState createState() => _InstagramTabState();
}

class _InstagramTabState extends State<InstagramTab> {
  late InstagramTabController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(InstagramTabController());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
        child: ListView.separated(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GetBuilder<SharedPreferencesController>(
                init: Get.find<SharedPreferencesController>(),
                builder: (value) {
                  var plan = controller.getPlanByIndex(
                      index, value.getInstagramModel());
                  if (plan.plan != null) {
                    return SelectionSlider(
                      key: Key(plan.title),
                      plan: plan.plan!,
                      planTitle: plan.title,
                    );
                  }
                  return Container();
                });
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}