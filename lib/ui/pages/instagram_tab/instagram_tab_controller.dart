import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/services/shared_preferences.dart';

class InstagramTabController extends GetxController {

  Plan getPlanByIndex(int index, InstagramModel? model) {
    switch (index) {
      case 0:
        return Plan(plan: model?.likes, title: 'Likes');
      case 1:
        return Plan(plan: model?.followers, title: 'Followers');
      case 2:
        return Plan(plan: model?.autoLikesPost, title: 'Auto-Likes');
      case 3:
        return Plan(plan: model?.views, title: 'Views');
      case 4:
        return Plan(plan: model?.comments, title: 'Comments');
    }
    return Plan(title: '', plan: null);
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
