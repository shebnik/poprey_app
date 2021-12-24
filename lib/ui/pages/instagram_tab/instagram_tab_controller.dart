import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/models/selector_widget_model.dart';
import 'package:poprey_app/services/app_preferences.dart';
import 'package:poprey_app/utils/app_constants.dart';

class InstagramTabController extends GetxController {
  late InstagramModel instagramModel;
  Rx<List<SelectorWidgetModel>> slidersList = Rx([]);

  final emptyModel = SelectorWidgetModel(
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
          plans: instagramModel.likes
              .map((e) => Plan(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                    disabled: Plan.checkIfDisabled(e.types),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Followers',
          plans: instagramModel.followers
              .map((e) => Plan(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                    disabled: Plan.checkIfDisabled(e.types),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Auto-Likes',
          plans: instagramModel.autoLikesPost
              .map((e) => Plan(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                    disabled: Plan.checkIfDisabled(e.types),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Views',
          plans: instagramModel.views
              .map((e) => Plan(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                    disabled: Plan.checkIfDisabled(e.types),
                  ))
              .toList(),
        ),
      ],
      ...[
        emptyModel.copyWith(
          countInfo: 'Comments',
          plans: instagramModel.comments
              .map((e) => Plan(
                    count: e.count.toInt(),
                    price: e.price.toDouble(),
                    disabled: Plan.checkIfDisabled(e.types),
                  ))
              .toList(),
        ),
      ],
    ];
  }
}
