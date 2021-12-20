import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/ui/widgets/account_selector/account_selector.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/app_bottom_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:poprey_app/utils/app_constants.dart';

class AppBottomSheet extends StatefulWidget {
  final SelectedPlan selectedPlan;

  const AppBottomSheet({
    required this.selectedPlan,
    Key? key,
  }) : super(key: key);

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  late BottomSheetController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BottomSheetController(widget.selectedPlan));
  }

  @override
  Widget build(BuildContext context) {
    controller.localization = AppLocalizations.of(context);
    return Obx(
      () => SafeArea(
        child: controller.isAccountSelector.value
            ? AccountSelector(controller: controller)
            : urlEmail(),
      ),
    );
  }

  Widget urlEmail() {
    return Wrap(
      children: [
        titleWidget(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() => CustomTextField(
                    label: controller.getUrlTitle,
                    controller: controller.userNameController.value,
                    inputType: controller.profileManager.profiles.isNotEmpty
                        ? InputType.expandMore
                        : null,
                    onExpandMore: controller.expandAccountsPressed,
                    errorText: controller.userNameErrorText.value,
                    showError: controller.isUserNameError.value,
                  )),
              Obx(() => CustomTextField(
                    label: AppConstants.email,
                    controller: controller.emailController.value,
                    errorText: controller.emailErrorText.value,
                    showError: controller.isEmailError.value,
                  )),
              const SizedBox(height: 35),
              BottomResetNavigation(
                resetPressed: () => Get.back(),
                nextPressed: () => controller.nextPressed(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget titleWidget() {
    return Container(
      height: 60,
      width: double.infinity,
      color: const Color(0xFFF7F8FB),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          const Positioned(
            top: 8,
            child: HomeIndicator(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: const Color(0xFFC9CFD6),
                  icon: const Icon(
                    Icons.close,
                    size: 15,
                  ),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
          Positioned(
            top: 25,
            child: Text(
              controller.getTitle,
              style: Theme.of(context).textTheme.headline3,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
