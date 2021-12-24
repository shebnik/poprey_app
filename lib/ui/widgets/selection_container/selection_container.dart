import 'package:flutter/material.dart';

import 'package:poprey_app/ui/widgets/gradient_icon.dart';
import 'package:poprey_app/ui/widgets/gradient_text.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectionContainer extends StatelessWidget {
  final String title;
  final List<String>? subtitles;
  final bool isSelected;

  const SelectionContainer({
    Key? key,
    required this.title,
    required this.isSelected,
    this.subtitles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: subtitles == null ? 55 : 170,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: isSelected
            ? null
            : AppTheme.isLightTheme(context)
                ? const Color(0xFFF7F8FB)
                : const Color(0xFF080704),
        gradient: isSelected ? AppTheme.getAppGradient(0.08) : null,
      ),
      child: Stack(
        children: [
          if (isSelected) ...[
            Positioned(
              top: 8,
              right: 8,
              child: GradientIcon(
                Icons.check_circle,
                size: 20,
                gradient: AppTheme.getAppGradient(),
              ),
            ),
          ],
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSelected
                      ? GradientText(
                          title,
                          gradient: AppTheme.getAppGradient(),
                          style: Theme.of(context).textTheme.headline4,
                        )
                      : Text(
                          title,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                ],
              ),
              subtitlesWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Widget subtitlesWidget() {
    if (subtitles == null) return const SizedBox.shrink();
    return Column(
      children: [
        const SizedBox(height: 20),
        ListView.separated(
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isSelected
                    ? GradientIcon(
                        Icons.verified_user_outlined,
                        gradient: AppTheme.getAppGradient(),
                        size: 12,
                      )
                    : const Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFFC9CFD6),
                        size: 12,
                      ),
                // Text(
                //   subtitles![index],
                //   style: Theme.of(context).textTheme.subtitle2?.apply(
                //         fontFamily: AppConstants.SFProDisplay,
                //       ),
                // ),
              ],
            );
          },
        ),
      ],
    );
  }
}
