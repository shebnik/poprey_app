import 'package:flutter/material.dart';

class UI {

  static Widget get empty => Container();

  static Widget get loading => const Center(child: CircularProgressIndicator());

  static Widget get doneIcon => const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      );
}
