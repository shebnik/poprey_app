import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:collection/collection.dart';

class AutoLikesSheetController {
  late final InstagramModel instagramModel;
  late final List<InstagramPlan> autoLikesPost, autoLikesSubs;
  late Plan planPrice;

  RxInt selectedIndex = RxInt(0);
  int currentPostIndex = 0, currentSubIndex = 0;

  AutoLikesSheetController(SelectedPlan selectedPlan) {
    planPrice = selectedPlan.plan;
    instagramModel = AppPreferences.getInstagramModel()!;
    autoLikesPost = instagramModel.autoLikesPost;
    autoLikesSubs = instagramModel.autoLikesSubs;

    currentPostIndex = getCurrentPostIndexByCount();
  }

  void setPlanPrice(Plan value, [int? index]) {
    planPrice = value;
    if (index == null) return;
    selectedIndex.value == 1
        ? currentSubIndex = index
        : currentPostIndex = index;
  }

  SelectionSliderModel getSelectedModel() {
    var model = SelectionSliderModel(
        platform: 'Instagram', countInfo: 'Auto-Likes', urlInfo: '', plans: []);

    return selectedIndex.value == 1
        ? model.copyWith(
          countInfo: 'Auto-Likes Subs',
            plans: autoLikesSubs
                .map((e) => Plan(
                      count: e.count.toInt(),
                      price: e.price.toDouble(),
                    ))
                .toList(),
          )
        : model.copyWith(
          countInfo: 'Auto-Likes Post',
            plans: autoLikesPost
                .map((e) => Plan(
                      count: e.count.toInt(),
                      price: e.price.toDouble(),
                    ))
                .toList(),
          );
  }

  int getInititalIndex() {
    return selectedIndex.value == 1 ? currentSubIndex : currentPostIndex;
  }

  int getCurrentPostIndexByCount() {
    final plan =
        autoLikesPost.firstWhereOrNull((e) => e.count == planPrice.count);
    if (plan == null) return 0;
    final index = autoLikesPost.indexOf(plan);
    if (index == -1) return 0;
    return index;
  }

  SelectedPlan getSelectedPlan() {
    return SelectedPlan.fromSelectionSliderModel(
        model: getSelectedModel(), plan: planPrice);
  }

  // int getInititalIndex(SelectedPlan selectedPlan) {
  //   switch (selectedIndex.value) {
  //     case 1:
  //       final plan = autoLikesSubs.plans
  //           .firstWhereOrNull((e) => e.count == selectedPlan.planPrice.count);
  //       if (plan == null) return 0;
  //       final index = autoLikesSubs.plans.indexOf(plan);
  //       if (index == -1) return 0;
  //       return index;
  //     case 0:
  //     default:
  //       final plan = autoLikesPost.plans
  //           .firstWhereOrNull((e) => e.count == selectedPlan.planPrice.count);
  //       if (plan == null) return 0;
  //       final index = autoLikesPost.plans.indexOf(plan);
  //       if (index == -1) return 0;
  //       return index;
  //   }
  // }
}
