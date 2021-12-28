import 'package:get/state_manager.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/services/sm_parser.dart';

class OtherSmOrderController extends GetxController {
  final SelectedPlan selectedPlan;
  late SMPlan plan;
  RxDouble totalPrice = 0.0.obs;
  late SmUrlModel? smUrlModel;

  RxInt selectedIndex = 0.obs;

  OtherSmOrderController(args) : selectedPlan = args[0] {
    plan = SelectedPlan.toSMPlan(selectedPlan)!;
    totalPrice = selectedPlan.plan.price.obs;
    smUrlModel = args[1];
  }

  String get getTitle =>
      '${selectedPlan.platform} ${selectedPlan.plan.count} ${selectedPlan.countInfo.split(' ')[0]}';

  void onPaymentResult(Map<String, dynamic> payment) {}

  void paymentMethodSelected(int i) {
    if (selectedIndex.value == i) return;
    selectedIndex.value = i;
  }
}
