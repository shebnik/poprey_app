import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:poprey_app/utils/logger.dart';

class MainController extends GetxController {
  RxBool isLoadingObs = true.obs;

  bool get isLoading => isLoadingObs.value;
  set isLoading(bool value) => isLoadingObs.value = value;

  static bool isOnline = true;
  RxBool isOnlineRx = true.obs;

  RxBool preventTapObx = false.obs;
  bool get preventTap => preventTapObx.value;
  set preventTap(bool value) => preventTapObx.value = value;

  late StreamSubscription connectivityStream;

  bool showingSubscribeDialog = false;

  void prepare() {
    initStreams();
  }

  void initStreams() {
    connectivityStream = Connectivity().onConnectivityChanged.listen((event) {
      isOnline = event != ConnectivityResult.none;
      isOnlineRx.value = isOnline;
      Logger.i("[Connectivity]: ${isOnline ? "Online" : "Offline"}");
    });
    Connectivity().checkConnectivity().then((value) {
      isOnline = value != ConnectivityResult.none;
      isOnlineRx.value = isOnline;
    });
  }

  @override
  void onClose() {
    connectivityStream.cancel();
    super.onClose();
  }
}
