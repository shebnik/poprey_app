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
    return Scrollbar(
      isAlwaysShown: false,
      thickness: 5,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GetBuilder<SharedPreferencesController>(
                init: Get.find<SharedPreferencesController>(),
                builder: (value) {
                  var model = controller.getPlanModelByIndex(
                      index, value.getInstagramModel());
                  if (model != null) {
                    return SelectionSlider(
                      model: model,
                      key: Key('${model.platform}-${model.countInfo}'),
                    );
                  }
                  return Container();
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        ),
      ),
    );
  }
}
