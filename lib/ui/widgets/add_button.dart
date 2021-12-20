import 'package:flutter/material.dart';

import 'package:poprey_app/utils/app_constants.dart';
import 'package:poprey_app/utils/app_theme.dart';

class AddButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AddButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            color: AppTheme.primaryBlue,
          ),
          const SizedBox(width: 18),
          Text(
            text,
            style: const TextStyle(
              fontFamily: AppConstants.SFProText,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
