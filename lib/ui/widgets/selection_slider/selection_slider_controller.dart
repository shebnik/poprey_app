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

  void initValues() {
    minValue = formatter.format(model.plans.first.count);
    maxValue = formatter.format(model.plans.last.count);

    countValue.value = formatter.format(model.plans.first.count);
    priceValue.value = model.plans.first.price.toStringAsFixed(2);
  }

  void onSliderChanged(double value) {
    currentValue.value = value;
    int index = value.toInt();

    countValue.value = formatter.format(model.plans[index].count);
    priceValue.value = model.plans[index].price.toStringAsFixed(2);
  }

  String? getImageAsset() {
    switch (model.planTitle.toLowerCase()) {
      case 'likes':
        return AppAssets.likes;
      case 'followers':
      case 'playlist followers':
      case 'group followers':
        return AppAssets.followers;
      case 'auto-likes':
      case 'page likes':
      case 'post likes':
        return AppAssets.autoLikes;
      case 'views':
        return AppAssets.views;
      case 'comments':
        return AppAssets.comments;
    }
  }
}
