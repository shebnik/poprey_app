import 'package:flutter/cupertino.dart';

class SplashLoadingWidget extends StatelessWidget {
  const SplashLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
