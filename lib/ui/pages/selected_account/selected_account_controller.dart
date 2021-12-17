import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/services/instagram_parser.dart';

class SelectedAccountController extends GetxController {
  final SelectedPlan? selectedPlan;

  SelectedAccountController(this.selectedPlan);

  fetchUserProfile() async {
    await InstagramParser.fetchInstagramProfile('shebalinik');
  }
}
