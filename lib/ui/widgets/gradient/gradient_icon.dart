import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon(
    this.icon, {
    required this.gradient,
    Key? key,
    this.size = 24,
  }) : super(key: key);

  final IconData icon;
  final Gradient gradient;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
