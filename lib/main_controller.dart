import 'dart:async';

import 'package:get/get.dart';
import 'package:poprey_app/services/shared_preferences.dart';

class MainController extends GetxController {
  RxBool isLoadingObs = true.obs;
  bool get isLoading => isLoadingObs.value;
  set isLoading(bool value) => isLoadingObs.value = value;

  RxBool isOnlineObs = true.obs;
  bool get isOnline => isOnlineObs.value;
  set isOnline(bool value) => isOnlineObs.value = value;

  late StreamSubscription connectivityStream;
  List<StreamSubscription> streamSubscriptions = [];

  bool showingSubscribeDialog = false;

  void prepare() {
    initStreams();
  }

  void initStreams() {
    // AuthService.listenAuthState();
    // SharedPreferencesService.initStreams();
    // connectivityStream = Connectivity().onConnectivityChanged.listen((event) {
    //   isOnline = event != ConnectivityResult.none;
    //   Logger.i("Connectivity: ${isOnline ? "Online" : "Offline"}");
    // });
    // Connectivity().checkConnectivity().then((value) {
    //   isOnline = value != ConnectivityResult.none;
    // });
  }

  @override
  void onClose() {
    streamSubscriptions.map((e) => e.cancel());
    // SharedPreferencesController.closeStreams();
    // firestoreDataChangeStreamController.close();
    connectivityStream.cancel();
    // PaymentService.instance.dispose();
    super.onClose();
  }
}
