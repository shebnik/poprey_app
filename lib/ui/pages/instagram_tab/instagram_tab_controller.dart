import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/utils/app_constants.dart';

class InstagramTabController extends GetxController {
  late InstagramModel instagramModel;
  Rx<List<SelectionSliderModel>> slidersList = Rx([]);

  final emptyModel = SelectionSliderModel(
    platform: AppConstants.Instagram,
    urlInfo: 'Instagram Username (Login)',
    countInfo: '',
    plans: [],
  );

  @override
  void onInit() {
    super.onInit();
    instagramModel = AppPreferences.getInstagramModel()!;
    setList();
  }

  void setList() {
    slidersList.value = [
      ...[
        emptyModel.copyWith(
          countInfo: 'Likes',
          plans: instagramModel.likes.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Followers',
          plans: instagramModel.followers.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Auto-Likes',
          plans: instagramModel.autoLikesPost.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Views',
          plans: instagramModel.views.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Comments',
          plans: instagramModel.comments.plans
              .map((e) => PlanPrice(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                  ))
              .toList(),
        ),
      ],
    ];
  }
}
