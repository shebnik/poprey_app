import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/instagram_post.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/sm_plans_model.dart';
import 'package:poprey_app/services/app_preferences.dart';

class OrderPageController extends GetxController {
  late final SelectedPlan selectedPlan;
  late final InstagramPlan plan;
  late final SMPlan smplan;
  late final List<InstagramPost>? selectedPosts;

  OrderPageController(List<dynamic> args) {
    selectedPlan = args[0];
    if (args.length > 1) {
      selectedPosts = args[1];
    }
    if(selectedPlan.platform == 'Instagram'){
    plan = AppPreferences.getInstagramModel()!.
    }
  }

  String getCount() {
    if (selectedPosts == null) return '';
    return selectedPosts!.isEmpty
        ? ''
        : (selectedPlan.planPrice.count ~/ (selectedPosts!.length)).toString();
  }
}
