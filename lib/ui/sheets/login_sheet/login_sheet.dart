import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poprey_app/utils/app_constants.dart';

class LoginSheet extends StatelessWidget {
  final LoginSheetController controller;

  const LoginSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.appLocalizations = AppLocalizations.of(context);
    return SafeArea(
      child: Wrap(
        children: [
          sheetTitle(context),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Obx(() => CustomTextField(
                      label: controller.getUrlTitle,
                      controller: controller.userNameController.value,
                      inputType: controller.inputType,
                      accountToggle: controller.chooseAccount,
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
                Obx(() {
                  var loading = controller.isLoading.value;

                  return BottomResetNavigation(
                    resetPressed: () => Get.back(),
                    nextPressed: () =>
                        loading ? null : controller.nextPressed(context),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sheetTitle(BuildContext context) {
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
