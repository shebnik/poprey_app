import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/instagram_post.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/utils.dart';

class OrderPageController extends GetxController {
  late final SelectedPlan selectedPlan;
  late final InstagramPlan plan;
  late final SMPlan smplan;
  List<InstagramPost>? selectedPosts;
  List<Extra> selectedExtras = [];

  RxInt typeSelectedIndex = RxInt(0);

  late RxString totalPrice;

  OrderPageController(List<dynamic> args) {
    selectedPlan = args[0];
    if (args.length > 1) {
      selectedPosts = args[1];
    }
    if (selectedPlan.platform == 'Instagram') {
      plan = SelectedPlan.toInstagramPlan(selectedPlan)!;
      totalPrice = Utils.formatAmount(selectedPlan.plan.price).obs;
    }
  }

  String get getTitle =>
      '${selectedPlan.platform} ${selectedPlan.plan.count} ${selectedPlan.countInfo.split(' ')[0]}';

  List<String> get getSubtitle1 =>
      AppConstants.TypesDescription[plan.types.first.name]!;

  List<String> get getSubtitle2 =>
      AppConstants.TypesDescription[plan.types.last.name]!;

  void setSelectedExtras(List<Extra> value) {
    selectedExtras = value;
    totalPrice.value = Utils.formatAmount(getTotalPrice);
  }

  @override
  void onReady() {
    super.onReady();
    if (plan.types.first.disabled) {
      typeSelectedIndex.value = 1;
    } else if (plan.types.last.disabled) {
      typeSelectedIndex.value = 0;
    }
    if (Plan.checkIfDisabled(plan.types)) {
      typeSelectedIndex.value = -1;
    }
  }

  String getCount() {
    if (selectedPosts == null) return '';
    return selectedPosts!.isEmpty
        ? ''
        : (selectedPlan.plan.count ~/ (selectedPosts!.length)).toString();
  }

  void buy() {}

  void updateTypeIndex(int index) {
    if (index == typeSelectedIndex.value) return;
    typeSelectedIndex.value = index;
    totalPrice.value = Utils.formatAmount(getTotalPrice);
  }

  double get getTotalPrice {
    double extrasCount = 0;
    for (var price in selectedExtras.map((e) => e.price).toList()) {
      extrasCount += price.toDouble();
    }
    return plan.types[typeSelectedIndex.value].price + extrasCount;
  }
}
