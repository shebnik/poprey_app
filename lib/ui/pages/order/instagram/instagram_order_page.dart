import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/pages/order/instagram/instagram_order_page_controller.dart';
import 'package:poprey_app/ui/widgets/bottom_payment.dart';
import 'package:poprey_app/ui/widgets/instagram_post_widget.dart';
import 'package:poprey_app/ui/widgets/order_app_bar.dart';
import 'package:poprey_app/ui/widgets/selection_container/selection_containers_row.dart';
import 'package:poprey_app/utils/app_theme.dart';

import 'extra_plans_column.dart';

class InstagramOrderPage extends StatefulWidget {
  static const routeName = '/order/instagram';
  const InstagramOrderPage({Key? key}) : super(key: key);

  @override
  _InstagramOrderPageState createState() => _InstagramOrderPageState();
}

class _InstagramOrderPageState extends State<InstagramOrderPage> {
  late InstagramOrderPageController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(InstagramOrderPageController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(title: AppLocale(context).youHaveChoosen),
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
      bottomNavigationBar: Obx(
        () => BottomPayment(
          amount: controller.totalPrice.value,
          onPaymentResult: controller.onPaymentResult,
        ),
      ),
    );
  }

  Widget selectedPosts() {
    if (controller.selectedPosts == null) return const SizedBox.shrink();
    return Container(
      // width: double.infinity,
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
            return LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.minHeight,
                  child: SelectImageWidget(
                    imageUrl: controller.selectedPosts![index].thumbnailSrc,
                    isSelected: true,
                    countInfo: controller.selectedPlan.countInfo,
                    count: controller.getCount(),
                  ),
                );
              },
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
