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
      appBar: OrderAppBar(title: AppLocale(context).youHaveChosen),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              selectedPosts(constraints),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      controller.selectedPosts.isEmpty
                          ? orderTitle()
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: SelectionContainersRow(
                          selectedIndex: controller.typeSelectedIndex,
                          updateIndex: controller.updateTypeIndex,
                          title1:
                              controller.plan.types.first.name.toUpperCase(),
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

  Widget selectedPosts(BoxConstraints constraints) {
    if (controller.selectedPosts.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: constraints.maxHeight / 2,
      ),
      color: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
      child: controller.isListOverflown
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: controller.toggleList,
                onVerticalDragEnd: (details) => controller.toggleList(),
                child: postsGrid(),
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                postsList(),
              ],
            ),
    );
  }

  Widget postsList() {
    return SizedBox(
      height: 92,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: controller.selectedPosts.length,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 9),
        itemBuilder: (BuildContext context, int index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.minHeight,
                child: SelectImageWidget(
                  imageUrl: controller.selectedPosts[index].thumbnailSrc,
                  isSelected: true,
                  iconSize: 12,
                  countInfo: controller.selectedPlan.countInfo,
                  count: controller.getCount(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget postsGrid() {
    return Obx(() {
      return GridView.builder(
        padding: EdgeInsets.only(
          top: 8,
          bottom: controller.isListOverflown ? 34 : 22,
        ),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.isPostsListExpanded.value
            ? controller.selectedPosts.length
            : controller.selectedPosts.length > 6
                ? 6
                : controller.selectedPosts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (controller.isPostsListExpanded.value == false && index == 5) {
            return Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '+${controller.selectedPosts.length - 5}',
                  style: Theme.of(context).textTheme.headline2?.apply(
                        color: AppTheme.primaryBlue,
                      ),
                ),
              ),
            );
          }
          return SelectImageWidget(
            imageUrl: controller.selectedPosts[index].thumbnailSrc,
            isSelected: true,
            iconSize: 12,
            countInfo: controller.selectedPlan.countInfo,
            count: controller.getCount(),
          );
        },
      );
    });
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
