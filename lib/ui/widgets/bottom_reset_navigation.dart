import 'package:flutter/material.dart';
import 'package:poprey_app/services/app_localizations.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';

class BottomResetNavigation extends StatelessWidget {
  final void Function()? resetPressed;
  final void Function()? nextPressed;

  const BottomResetNavigation({
    Key? key,
    required this.resetPressed,
    required this.nextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocale(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: resetPressed,
          child: Text(
            locale.reset,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: RoundButton(
            onPressed: nextPressed,
            title: locale.next,
          ),
        ),
      ],
    );
  }
}
