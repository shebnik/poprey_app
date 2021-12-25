import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/order/order_page_controller.dart';
import 'package:poprey_app/ui/widgets/instagram_post_widget.dart';
import 'package:poprey_app/ui/widgets/order_app_bar.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';
import 'package:poprey_app/ui/widgets/selection_container/selection_containers_row.dart';
import 'package:poprey_app/utils/app_theme.dart';

import 'extra_plans_column.dart';

class OrderPage extends StatefulWidget {
  static const routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  late OrderPageController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(OrderPageController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const OrderAppBar(title: 'You have chosen'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              selectedPosts(),
              controller.selectedPosts == null
                  ? orderTitle()
                  : const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SelectionContainersRow(
                  selectedIndex: controller.typeSelectedIndex,
                  updateIndex: controller.updateTypeIndex,
                  title1: controller.plan.types.first.name.toUpperCase(),
                  title2: controller.plan.types.last.name.toUpperCase(),
                  shouldApplyBorder: true,
                  subtitles1: controller.getSubtitle1,
                  subtitles2: controller.getSubtitle2,
                  title1Disabled: controller.plan.types.first.disabled,
                  title2Disabled: controller.plan.types.last.disabled,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ExtraPlansColumn(
                  extras: controller.plan.extras ?? [],
                  setSelectedExtras: controller.setSelectedExtras,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 12, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() {
              return Text(
                controller.totalPrice.value,
                style: Theme.of(context).textTheme.headline4?.apply(
                      fontWeightDelta: -1,
                      color: AppTheme.primary(context),
                    ),
              );
            }),
            const SizedBox(width: 20),
            SizedBox(
              width: 200,
              height: 40,
              child: RoundButton(
                title: 'Buy with',
                onPressed: controller.buy,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedPosts() {
    if (controller.selectedPosts == null) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      height: 92,
      color: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
      child: Center(
        child: ListView.separated(
          itemCount: controller.selectedPosts!.length > 6
              ? 6
              : controller.selectedPosts!.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          separatorBuilder: (context, index) => const SizedBox(width: 9.5),
          itemBuilder: (context, index) {
            if (index == 5) {
              return Center(
                child: Text(
                  '+${controller.selectedPosts!.length - 5}',
                  style: Theme.of(context).textTheme.headline2?.apply(
                        color: AppTheme.primaryBlue,
                      ),
                ),
              );
            }
            return InstagramPostWidget(
              post: controller.selectedPosts![index],
              isSelected: true,
              countInfo: controller.selectedPlan.countInfo,
              count: controller.getCount(),
            );
          },
        ),
      ),
    );
  }

  Widget orderTitle() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Text(
          controller.getTitle,
          style: Theme.of(context).textTheme.headline3,
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
