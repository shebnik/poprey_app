import 'package:get/state_manager.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';

class OtherSmOrderController extends GetxController {
  final SelectedPlan selectedPlan;
  late SMPlan plan;
  RxDouble totalPrice = 0.0.obs;

  OtherSmOrderController(args) : selectedPlan = args[0] {
    plan = SelectedPlan.toSMPlan(selectedPlan)!;
    totalPrice = selectedPlan.plan.price.obs;
  }

  void onPaymentResult(Map<String, dynamic> p1) {
  }
}
