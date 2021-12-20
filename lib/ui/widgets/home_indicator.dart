import 'package:flutter/material.dart';

class HomeIndicator extends StatelessWidget {
  const HomeIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 4,
      decoration: const BoxDecoration(
        color: Color(0xFFE1E4E8),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
    );
  }
}
