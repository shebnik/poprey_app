import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/instagram_post.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/utils/app_constants.dart';

class OrderPageController extends GetxController {
  late final SelectedPlan selectedPlan;
  late final InstagramPlan plan;
  late final SMPlan smplan;
  List<InstagramPost>? selectedPosts;

  RxInt selectedIndex = RxInt(0);

  OrderPageController(List<dynamic> args) {
    selectedPlan = args[0];
    if (args.length > 1) {
      selectedPosts = args[1];
    }
    if (selectedPlan.platform == 'Instagram') {
      plan = SelectedPlan.toInstagramPlan(selectedPlan)!;
      print(plan.toString());
      for (var item in plan.types) {
        print(item.toString());
      }
    }
  }

  String get getTitle =>
      '${selectedPlan.platform} ${selectedPlan.plan.count} ${selectedPlan.countInfo}';

  List<String> get getSubtitle1 => AppConstants.TypesDescription[plan.types.first.name]!;

  List<String> get getSubtitle2 => AppConstants.TypesDescription[plan.types.last.name]!;

  String getCount() {
    if (selectedPosts == null) return '';
    return selectedPosts!.isEmpty
        ? ''
        : (selectedPlan.plan.count ~/ (selectedPosts!.length)).toString();
  }
}
