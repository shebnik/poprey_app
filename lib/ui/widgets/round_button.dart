import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final int fontWeightDelta;

  const RoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontWeightDelta = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .button
            ?.apply(fontWeightDelta: fontWeightDelta),
      ),
    );
  }
}
