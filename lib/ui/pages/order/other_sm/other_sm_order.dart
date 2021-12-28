import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/bottom_payment.dart';
import 'package:poprey_app/ui/widgets/icon_row.dart';
import 'package:poprey_app/ui/widgets/instagram_post_widget.dart';
import 'package:poprey_app/ui/widgets/order_app_bar.dart';
import 'package:poprey_app/ui/widgets/selection_row.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/utils/utils.dart';
import 'other_sm_order_controller.dart';

class OtherSmOrder extends StatefulWidget {
  static const routeName = '/order/othersm';
  const OtherSmOrder({Key? key}) : super(key: key);

  @override
  _OtherSmOrderState createState() => _OtherSmOrderState();
}

class _OtherSmOrderState extends State<OtherSmOrder> {
  late OtherSmOrderController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(OtherSmOrderController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OrderAppBar(title: AppLocale(context).youHaveChosen),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              selectedUrl(),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: infoBox(),
              ),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: paymentMethods(),
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

  Widget selectedUrl() {
    if (controller.smUrlModel == null) return orderTitle();
    return Container(
      height: 100,
      color: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (controller.smUrlModel!.image != null) ...[
              SizedBox(
                width: 120,
                height: 70,
                child: SelectImageWidget(
                  imageUrl: controller.smUrlModel!.image!,
                  isSelected: true,
                  count: controller.selectedPlan.plan.count.toString(),
                  countInfo: controller.selectedPlan.countInfo,
                ),
              ),
            ],
            const SizedBox(width: 14),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 22),
                    child: Text(
                      controller.smUrlModel?.title != null
                          ? controller.smUrlModel!.title!
                          : controller.selectedPlan.url!,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary(context),
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${controller.selectedPlan.plan.count} ${controller.selectedPlan.countInfo.toLowerCase()}',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFA6A6A6),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoBox() {
    return Container(
      height: 100,
      color: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconRow(
                text: controller.plan.info[0].toLowerCase(),
                isGradient: false,
              ),
              const SizedBox(height: 10),
              IconRow(
                text: controller.plan.info[1].toLowerCase(),
                isGradient: false,
                boldText: true,
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconRow(
                text: controller.plan.info[2].toLowerCase(),
                isGradient: false,
              ),
              const SizedBox(height: 10),
              IconRow(
                text: controller.plan.info[3].toLowerCase(),
                isGradient: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentMethods() {
    return Column(
      children: [
        Obx(() {
          return SelectionRow(
            title: 'Debit/Credit cards',
            subtitle: Utils.formatAmount(controller.selectedPlan.plan.price),
            hasBorder: true,
            subtitleColor: const Color(0xFF58CD73),
            isSelected: controller.selectedIndex.value == 0,
            onTap: () => controller.paymentMethodSelected(0),
          );
        }),
        const SizedBox(height: 10),
        Obx(() {
          return SelectionRow(
            title: 'Cryptocurrency',
            subtitle: Utils.formatAmount(controller.selectedPlan.plan.price),
            hasBorder: true,
            subtitleColor: const Color(0xFF58CD73),
            isSelected: controller.selectedIndex.value == 1,
            onTap: () => controller.paymentMethodSelected(1),
          );
        }),
        const SizedBox(height: 10),
        Obx(() {
          return SelectionRow(
            title: 'Paypal/Credit cards',
            subtitle: Utils.formatAmount(controller.selectedPlan.plan.price),
            subtitleColor: const Color(0xFF58CD73),
            hasBorder: true,
            isSelected: controller.selectedIndex.value == 2,
            onTap: () => controller.paymentMethodSelected(2),
          );
        }),
      ],
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
