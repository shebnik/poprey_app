import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/models/selection_slider_model.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/app_assets.dart';
import 'package:poprey_app/utils/utils.dart';

class SelectionSliderController extends GetxController {
  final SelectionSliderModel model;

  SelectionSliderController(this.model);

  RxDouble currentValue = 0.0.obs;
  RxString countValue = RxString('');
  RxString priceValue = RxString('');
  String minValue = '', maxValue = '';

  int index = 0;
  int get currentCount => model.plans[index].count;
  double get currentPrice => model.plans[index].price;

  String get getPriceAmmount => '\$${priceValue.value}';

  void initValues() {
    minValue = Utils.formatNumber(model.plans.first.count);
    maxValue = Utils.formatNumber(model.plans.last.count);

    countValue.value = Utils.formatNumber(model.plans.first.count);
    priceValue.value = model.plans.first.price.toStringAsFixed(2);
  }

  void onSliderChanged(double value) {
    currentValue.value = value;
    index = value.toInt();

    countValue.value = Utils.formatNumber(currentCount);
    priceValue.value = currentPrice.toStringAsFixed(2);
  }

  String? getImageAsset() {
    switch (model.countInfo.toLowerCase()) {
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

  void buyPressed() {
    Widgets.showBottomSheet(
      SelectedPlan.fromSelectionSliderModel(
        model: model,
        planPrice: PlanPrice(
          count: currentCount,
          price: currentPrice,
        ),
      ),
    );
  }
}
