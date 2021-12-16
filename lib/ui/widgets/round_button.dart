
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.fontWeightDelta = 0,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final int fontWeightDelta;

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
