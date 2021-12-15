import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/utils/app_assets.dart';

class SelectionSliderController extends GetxController {
  final SelectionSliderModel model;

  SelectionSliderController(this.model);

  final NumberFormat formatter = NumberFormat();

  RxDouble currentValue = 0.0.obs;
  RxString countValue = RxString('');
  RxString priceValue = RxString('');
  String minValue = '', maxValue = '';

  int sliderIndex = 0;

  void initValues() {
    currentValue.value = model.minValue;
    minValue = formatter.format(model.plans.first.count);
    maxValue = formatter.format(model.plans.last.count);

    countValue.value = formatter.format(model.plans.first.count);
    priceValue.value = model.plans.first.price.toStringAsFixed(2);
  }

  void onSliderChanged(double value) {
    currentValue.value = value;
    sliderIndex = getSliderIndex(value);

    countValue.value = formatter.format(model.plans[sliderIndex].count);
    priceValue.value = model.plans[sliderIndex].price.toStringAsFixed(2);
  }

  int getSliderIndex(double value) {
    return value ~/ (model.maxValue ~/ model.divisions);
  }

  String getImageAsset() {
    switch (model.planTitle.toLowerCase()) {
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
