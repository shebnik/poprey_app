import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider.dart';

class InstagramTabController extends GetxController {
  SelectionSliderModel? getPlanModelByIndex(int index, InstagramModel? model) {
    if (model == null) return null;
    switch (index) {
      case 0:
        return SelectionSliderModel(
          planTitle: 'Likes',
          plans: model.likes.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 1:
        return SelectionSliderModel(
          planTitle: 'Followers',
          plans: model.followers.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 2:
        return SelectionSliderModel(
          planTitle: 'Auto-Likes',
          plans: model.autoLikesPost.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 3:
        return SelectionSliderModel(
          planTitle: 'Views',
          plans: model.views.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        );
      case 4:
        return SelectionSliderModel(
          planTitle: 'Comments',
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
