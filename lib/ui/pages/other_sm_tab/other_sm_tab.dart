import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/other_sm_tab/other_sm_tab_controller.dart';
import 'package:poprey_app/ui/widgets/selector_widget/selector_widget.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'other_sm_selection_list.dart';

class OtherSmTab extends StatefulWidget {
  const OtherSmTab({Key? key}) : super(key: key);

  @override
  _OtherSmTabState createState() => _OtherSmTabState();
}

class _OtherSmTabState extends State<OtherSmTab>
    with AutomaticKeepAliveClientMixin {
  final OtherSmTabController controller = Get.find();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        OtherSMSelectionList(controller: controller),
        Expanded(
          child: RawScrollbar(
            crossAxisMargin: 2,
            thumbColor: AppTheme.primaryColor,
            radius: const Radius.circular(30),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: listView(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget listView() {
    return Obx(() {
      var model = controller.slidersList.value;
      return ListView.separated(
        controller: ScrollController(),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: model.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String key = '${model[index].platform}-${model[index].countInfo}';
          return SelectorWidget(
            model: model[index],
            key: Key(key),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      );
    });
  }
}
