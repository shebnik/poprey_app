import 'package:get/get.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/utils/app_assets.dart';

class SelectionSliderController extends GetxController {
  final InstagramPlan plan;

  SelectionSliderController(this.plan);

  late double minValue;
  late double maxValue;
  late int divisions;

  RxDouble currentValue = 0.0.obs;
  RxString countValue = RxString('');
  RxString priceValue = RxString('');
  int sliderIndex = 0;

  void initValues() {
    minValue = plan.plans.first.count.toDouble();
    maxValue = plan.plans.last.count.toDouble();
    divisions = plan.plans.length - 1;
    currentValue.value = minValue;

    countValue.value = minValue.toStringAsFixed(0);
    priceValue.value = plan.plans.first.price.toStringAsFixed(2);
  }

  void onSliderChanged(double value) {
    currentValue.value = value;
    sliderIndex = getSliderIndex(value);

    countValue.value = plan.plans[sliderIndex].count.toStringAsFixed(0);
    priceValue.value = plan.plans[sliderIndex].price.toStringAsFixed(2);
  }

  int getSliderIndex(double value) {
    return value ~/ (maxValue ~/ divisions);
  }

  String getAssetByTitle(String title) {
    switch (title.toLowerCase()) {
      case 'likes':
        return AppAssets.likes;
      case 'followers':
        return AppAssets.followers;
      case 'auto-likes':
        return AppAssets.autoLikes;
      case 'views':
        return AppAssets.views;
      case 'comments':
        return AppAssets.comments;
    }
    return '';
  }
}
