import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/instagram_tab/instagram_tab_controller.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider.dart';
import 'package:poprey_app/utils/app_theme.dart';

class InstagramTab extends StatefulWidget {
  const InstagramTab({Key? key}) : super(key: key);

  @override
  _InstagramTabState createState() => _InstagramTabState();
}

class _InstagramTabState extends State<InstagramTab>
    with AutomaticKeepAliveClientMixin {
  final InstagramTabController controller = Get.find();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RawScrollbar(
      crossAxisMargin: 2,
      thumbColor: AppTheme.primary,
      radius: const Radius.circular(30),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
          child: Obx(() {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.slidersList.value.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final model = controller.slidersList.value[index];
                return SelectionSlider(
                  model: model,
                  key: Key('${model.platform}-${model.countInfo}'),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            );
          }),
        ),
      ),
    );
  }
}
