import 'package:flutter/material.dart';
import 'package:poprey_app/ui/widgets/gradient/gradient_icon.dart';
import 'package:poprey_app/ui/widgets/gradient/gradient_painter.dart';
import 'package:poprey_app/ui/widgets/gradient/gradient_text.dart';
import 'package:poprey_app/ui/widgets/icon_row.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectionContainer extends StatelessWidget {
  final String title;
  final List<String>? subtitles;
  final bool isSelected;
  final bool hasBorder;
  final void Function()? onTap;

  const SelectionContainer({
    Key? key,
    required this.title,
    required this.isSelected,
    this.hasBorder = false,
    this.subtitles,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: hasBorder && isSelected
          ? GradientPainter(
              strokeWidth: 1,
              radius: 5,
              gradient: AppTheme.getAppGradient(),
            )
          : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: onTap,
        child: Container(
          height: subtitles == null ? 55 : 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isSelected
                ? null
                : AppTheme.isLightTheme(context)
                    ? const Color(0xFFF7F8FB)
                    : const Color(0xFF080704),
            gradient: isSelected ? AppTheme.getAppGradient(0.08) : null,
          ),
          child: content(context),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Stack(
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
            subtitlesWidget(context),
          ],
        ),
      ],
    );
  }

  Widget subtitlesWidget(BuildContext context) {
    if (subtitles == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        IconRow(text: subtitles![0], isSelected: isSelected),
        const SizedBox(height: 10),
        IconRow(text: subtitles![1], isSelected: isSelected, boldText: true),
        const SizedBox(height: 10),
        IconRow(text: subtitles![2], isSelected: isSelected),
        const SizedBox(height: 10),
        IconRow(text: subtitles![3], isSelected: isSelected),
      ],
    );
  }
}