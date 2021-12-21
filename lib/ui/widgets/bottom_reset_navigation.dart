import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:poprey_app/ui/widgets/round_button.dart';

class BottomResetNavigation extends StatelessWidget {
  final VoidCallback resetPressed;
  final VoidCallback nextPressed;
  final bool? disabled;

  const BottomResetNavigation({
    Key? key,
    required this.resetPressed,
    required this.nextPressed,
    this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: resetPressed,
          child: Text(
            localization?.reset ?? 'Reset',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: RoundButton(
            onPressed: nextPressed,
            title: localization?.next ?? 'Next',
            disabled: disabled,
          ),
        ),
      ],
    );
  }
}
