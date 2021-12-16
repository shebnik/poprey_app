import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/shared_preferences.dart';
import 'package:poprey_app/ui/pages/other_sm/other_sm_tab_controller.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider.dart';
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
        Expanded(
          child: Scrollbar(
            isAlwaysShown: false,
            thickness: 5,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: GetBuilder<SharedPreferencesController>(
                  builder: (value) {
                    final model = value.getSMPlansModel();
                    if (model == null) return Container();
                    controller.setModel(model);
                    return listView();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listView() {
    return Obx(() {
      var model = controller.selectionSliderModel.value;
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String key = '${model[index].platform}-${model[index].countInfo}';
          return SelectionSlider(
            model: model[index],
            key: Key(key),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );
    });
  }
}
