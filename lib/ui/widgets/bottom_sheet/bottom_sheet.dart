import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:poprey_app/ui/widgets/custom_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';

class AppBottomSheet extends StatefulWidget {
  final String title;

  const AppBottomSheet({
    required this.title,
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
    controller = Get.put(BottomSheetController());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          topBar(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Obx(() => CustomTextField(
                      label: 'Instagram Username (Login)',
                      controller: controller.userNameController.value,
                      inputType: InputType.expandMore,
                      onExpandMore: () {},
                    )),
                Obx(() => CustomTextField(
                      label: 'Email',
                      controller: controller.emailController.value,
                    )),
                const SizedBox(height: 30),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        AppLocalizations.of(context).reset,
                      ),
                    ),
                    Expanded(
                      child: RoundButton(
                        onPressed: () => {},
                        title: AppLocalizations.of(context).next,
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
              widget.title,
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
