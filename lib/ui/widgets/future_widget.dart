import 'package:flutter/cupertino.dart';
import 'package:poprey_app/ui/widgets/loading_widget.dart';

class FutureWidget extends StatelessWidget {
  final Future<dynamic> future;
  final Widget Function(BuildContext, AsyncSnapshot) onDidInitialize;
  const FutureWidget({
    Key? key,
    required this.future,
    required this.onDidInitialize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return onDidInitialize(context, snapshot);
        } else {
          return const SplashLoadingWidget();
        }
      },
    );
  }
}
