import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/utils/app_constants.dart';

class InstagramTabController extends GetxController {
  SelectionSliderModel? getPlanModelByIndex(int index, InstagramModel? model) {
    if (model == null) return null;

    final selectionSliderModel = SelectionSliderModel(
      platform: AppConstants.Instagram,
      urlInfo: 'Instagram Username (Login)',
      countInfo: '',
      plans: [],
    );

    switch (index) {
      case 0:
        return selectionSliderModel.copyWith(
          countInfo: 'Likes',
          plans: model.likes.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 1:
        return selectionSliderModel.copyWith(
          countInfo: 'Followers',
          plans: model.followers.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 2:
        return selectionSliderModel.copyWith(
          countInfo: 'Auto-Likes',
          plans: model.autoLikesPost.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 3:
        return selectionSliderModel.copyWith(
          countInfo: 'Views',
          plans: model.views.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 4:
        return selectionSliderModel.copyWith(
          countInfo: 'Comments',
          plans: model.comments.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
    }
  }
}

class Plan {
  final String title;
  final InstagramPlan? plan;

  Plan({
    required this.title,
    required this.plan,
  });
}
