import 'package:get/state_manager.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:collection/collection.dart';

class AutoLikesSheetController {
  late final InstagramModel instagramModel;
  late final List<InstagramPlan> autoLikesPost, autoLikesSubs;
  late Plan plan;

  RxBool isBuyDisabled = false.obs;

  RxInt selectedIndex = RxInt(0);
  int currentPostIndex = 0, currentSubIndex = 0;

  AutoLikesSheetController(SelectedPlan selectedPlan) {
    plan = selectedPlan.plan;
    instagramModel = AppPreferences.getInstagramModel()!;
    autoLikesPost = instagramModel.autoLikesPost;
    autoLikesSubs = instagramModel.autoLikesSubs;

    currentPostIndex = getCurrentPostIndexByCount();
  }

  void setPlan(Plan value, [int? index]) {
    plan = value;
    storeIndex(index);
  }

  void updatePlan(Plan value, [int? index]) {
    plan = value;
    isBuyDisabled.value = value.disabled;
    storeIndex(index);
  }

  storeIndex(int? index) {
    if (index == null) return;
    selectedIndex.value == 1
        ? currentSubIndex = index
        : currentPostIndex = index;
  }

  SelectorWidgetModel getSelectedModel() {
    var model = SelectorWidgetModel(
      platform: 'Instagram',
      countInfo: 'Auto-Likes',
      urlInfo: 'Instagram Username (Login)',
      plans: [],
    );

    return selectedIndex.value == 1
        ? model.copyWith(
            countInfo: 'Auto-Likes Subs',
            plans: autoLikesSubs
                .map((e) => Plan(
                      count: e.count.toInt(),
                      price: e.price.toDouble(),
                      disabled: Plan.checkIfDisabled(e.types),
                    ))
                .toList(),
          )
        : model.copyWith(
            countInfo: 'Auto-Likes Post',
            plans: autoLikesPost
                .map((e) => Plan(
                      count: e.count.toInt(),
                      price: e.price.toDouble(),
                      disabled: Plan.checkIfDisabled(e.types),
                    ))
                .toList(),
          );
  }

  int getInititalIndex() {
    return selectedIndex.value == 1 ? currentSubIndex : currentPostIndex;
  }

  int getCurrentPostIndexByCount() {
    final instagramPlan =
        autoLikesPost.firstWhereOrNull((e) => e.count == plan.count);
    if (instagramPlan == null) return 0;
    final index = autoLikesPost.indexOf(instagramPlan);
    if (index == -1) return 0;
    return index;
  }

  SelectedPlan getSelectedPlan() {
    return SelectedPlan.fromSelectionSliderModel(
      model: getSelectedModel(),
      plan: plan,
    );
  }
}
