import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/widgets/gradient/gradient_text.dart';
import 'package:poprey_app/ui/widgets/selection_container/selection_container.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectionContainersRow extends StatelessWidget {
  final RxInt selectedIndex;
  final void Function(int index) updateIndex;

  final String title1;
  final List<String>? subtitles1;
  final bool title1Disabled;

  final String title2;
  final List<String>? subtitles2;
  final bool title2Disabled;

  final bool subtitle30daysShown;
  final bool shouldApplyBorder;

  const SelectionContainersRow({
    Key? key,
    required this.updateIndex,
    required this.selectedIndex,
    required this.title1,
    this.subtitles1,
    required this.title2,
    this.subtitles2,
    this.subtitle30daysShown = false,
    this.shouldApplyBorder = false,
    this.title1Disabled = false,
    this.title2Disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Obx(() {
            return SelectionContainer(
              title: title1,
              isSelected: selectedIndex.value == 0,
              hasBorder: shouldApplyBorder,
              subtitles: subtitles1,
              isDisabled: title1Disabled,
              onTap: () => updateIndex(0),
            );
          }),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Obx(() {
                return SelectionContainer(
                  title: title2,
                  isSelected: selectedIndex.value == 1,
                  hasBorder: shouldApplyBorder,
                  subtitles: subtitles2,
                  isDisabled: title2Disabled,
                  onTap: () => updateIndex(1),
                );
              }),
              if (subtitle30daysShown) ...[
                const SizedBox(height: 1),
                Obx(
                  () => selectedIndex.value == 1
                      ? GradientText(
                          '30 days',
                          gradient: AppTheme.getAppGradient(),
                          style: Theme.of(context).textTheme.headline6,
                        )
                      : Text(
                          '30 days',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: const Color(0xFFA9B3D0),
                                  ),
                        ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
