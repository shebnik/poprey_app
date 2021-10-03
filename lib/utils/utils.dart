import 'package:flutter/material.dart';
import 'package:poprey_app/utils/ui.dart';

class Utils {
  static Widget futureWidget({
    required Future<dynamic> future,
    required Widget Function(BuildContext, AsyncSnapshot) onDidInitialize,
  }) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return onDidInitialize(context, snapshot);
        } else if (snapshot.hasError) {
          return UI.errorIcon;
        } else {
          return UI.loading;
        }
      },
    );
  }
}
