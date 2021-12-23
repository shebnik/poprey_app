import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_post.dart';
import 'package:poprey_app/models/selected_plan_model.dart';

class OrderPageController extends GetxController {
  late final SelectedPlan selectedPlan;
  late final List<InstagramPost>? selectedPosts;

  OrderPageController(List<dynamic> args) {
    selectedPlan = args[0];
    if (args.length > 1) {
      selectedPosts = args[1];
    }
  }

  String getCount() {
    if (selectedPosts == null) return '';
    return selectedPosts!.isEmpty
        ? ''
        : (selectedPlan.planPrice.count ~/ (selectedPosts!.length)).toString();
  }
}
