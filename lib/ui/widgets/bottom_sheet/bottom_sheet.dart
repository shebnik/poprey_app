import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/models/selected_plan_model.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';
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

  late AppLocalizations? localization;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BottomSheetController(widget.selectedPlan));
  }

  @override
  Widget build(BuildContext context) {
    localization = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          topBar(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Obx(() => CustomTextField(
                      label: controller.getUrlTitle,
                      controller: controller.userNameController.value,
                      inputType: InputType.expandMore,
                      onExpandMore: controller.expandMorePressed,
                      errorText:
                          localization?.wrongUserName ?? 'Username is wrong',
                      showError: controller.isUserNameError.value,
                    )),
                Obx(() => CustomTextField(
                      label: AppConstants.email,
                      controller: controller.emailController.value,
                      errorText: localization?.wrongEmail ?? 'Email is wrong',
                      showError: controller.isEmailError.value,
                    )),
                const SizedBox(height: 35),
                Row(
                  children: [
                    TextButton(
                      onPressed: controller.resetPressed,
                      child: Text(
                        localization?.reset ?? 'Reset',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: RoundButton(
                        onPressed: () => controller.nextPressed(context),
                        title: localization?.next ?? 'Next',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topBar() {
    return Container(
      height: 60,
      width: double.infinity,
      color: const Color(0xFFF7F8FB),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 8,
            child: Container(
              width: 35,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xFFE1E4E8),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
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
