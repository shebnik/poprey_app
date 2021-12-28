import 'package:flutter/material.dart';

class BottomShadow extends StatelessWidget {
  final bool isEnabled;
  final double? height;
  final Color? color;

  const BottomShadow({
    Key? key,
    required this.isEnabled,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) return const SizedBox.shrink();
    return IgnorePointer(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: height ?? MediaQuery.of(context).size.height / 8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color?.withOpacity(0.7) ??
                    const Color(0xFFC4C4C4).withOpacity(0.7),
                color?.withOpacity(0) ?? const Color(0xFFC4C4C4).withOpacity(0),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
      ),
    );
  }
}
