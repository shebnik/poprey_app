import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/sheets/login_sheet/login_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:poprey_app/ui/widgets/home_indicator.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class LoginSheet extends StatelessWidget {
  final LoginSheetController controller;

  const LoginSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.appLocale = AppLocale(context);
    return Wrap(
      children: [
        sheetTitle(context),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() => CustomTextField(
                    label: controller.getUrlTitle,
                    controller: controller.firstInputController.value,
                    inputType: controller.inputType,
                    accountToggle: controller.chooseAccount,
                    errorText: controller.userNameErrorText.value,
                    showError: controller.isFirstInputError.value,
                  )),
              Obx(() => CustomTextField(
                    label: AppConstants.email,
                    controller: controller.emailController.value,
                    errorText: controller.emailErrorText.value,
                    showError: controller.isEmailError.value,
                  )),
              const SizedBox(height: 34),
              Obx(() {
                var isLoading = controller.isLoading.value;
                return BottomResetNavigation(
                  resetPressed: isLoading ? null : () => Get.back(),
                  nextPressed: isLoading
                      ? null
                      : () => controller.nextPressed(context),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget sheetTitle(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: AppTheme.isLightTheme(context)
          ? const Color(0xFFF7F8FB)
          : const Color(0xFF080704),
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
