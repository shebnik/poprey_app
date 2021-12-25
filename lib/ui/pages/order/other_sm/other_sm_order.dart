import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/bottom_payment.dart';
import 'package:poprey_app/ui/widgets/icon_row.dart';
import 'package:poprey_app/ui/widgets/order_app_bar.dart';
import 'package:poprey_app/utils/app_theme.dart';
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
      appBar: OrderAppBar(title: AppLocale(context).youHaveChoosen),
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
    return Row(
      children: [],
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
                  isGradient: false),
              const SizedBox(height: 10),
              IconRow(
                  text: controller.plan.info[1].toLowerCase(),
                  isGradient: false,
                  boldText: true),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconRow(
                  text: controller.plan.info[2].toLowerCase(),
                  isGradient: false),
              const SizedBox(height: 10),
              IconRow(
                  text: controller.plan.info[3].toLowerCase(),
                  isGradient: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget paymentMethods() {
    return Row();
  }
}
