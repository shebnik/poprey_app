import 'package:flutter/material.dart';
import 'package:poprey_app/ui/widgets/gradient/gradient_icon.dart';
import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class IconRow extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool boldText;
  const IconRow({
    Key? key,
    required this.text,
    required this.isSelected,
    this.boldText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        isSelected
            ? GradientIcon(
                Icons.verified_user_outlined,
                gradient: AppTheme.getAppGradient(),
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
                      style: Theme.of(context).textTheme.subtitle2?.apply(
                            fontFamily: AppConstants.SFProDisplay,
                            fontWeightDelta: 3,
                          ),
                    ),
                    TextSpan(
                      text: ' ' + text.split(' ')[1],
                      style: Theme.of(context).textTheme.subtitle2?.apply(
                            fontFamily: AppConstants.SFProDisplay,
                          ),
                    ),
                  ],
                ),
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.subtitle2?.apply(
                      fontFamily: AppConstants.SFProDisplay,
                    ),
              ),
      ],
    );
  }
}
