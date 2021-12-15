import 'package:get/state_manager.dart';

class OtherSmTabController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void onSelected(int index) => selectedIndex.value = index;
}
