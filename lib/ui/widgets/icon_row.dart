import 'package:flutter/material.dart';

import 'package:poprey_app/ui/widgets/gradient/gradient_icon.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class IconRow extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isGradient;
  final bool boldText;
  const IconRow({
    Key? key,
    required this.text,
    this.isSelected = true,
    this.isGradient = true,
    this.boldText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle2?.apply(
          fontFamily: AppConstants.SFProDisplay,
          color: AppTheme.primary(context),
        );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isSelected
            ? isGradient
                ? GradientIcon(
                    Icons.verified_user_outlined,
                    gradient: AppTheme.getAppGradient(),
                    size: 14,
                  )
                : Icon(
                    Icons.verified_user_outlined,
                    color: AppTheme.primary(context),
                    size: 14,
                  )
            : const Icon(
                Icons.verified_user_outlined,
                color: Color(0xFFC9CFD6),
                size: 14,
              ),
        const SizedBox(width: 9),
        boldText
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: text.split(' ')[0],
                      style: textStyle?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: ' ' + text.split(' ')[1],
                      style: textStyle,
                    ),
                  ],
                ),
              )
            : Text(
                text,
                style: textStyle,
              ),
      ],
    );
  }
}
