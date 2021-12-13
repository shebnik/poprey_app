import 'package:flutter/material.dart';
import 'package:poprey_app/models/instagram_model.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider.dart';
import 'package:poprey_app/utils/logger.dart';

class InstagramTab extends StatefulWidget {
  final InstagramModel? instagramModel;
  const InstagramTab({
    Key? key,
    required this.instagramModel,
  }) : super(key: key);

  @override
  _InstagramTabState createState() => _InstagramTabState();
}

class _InstagramTabState extends State<InstagramTab> {
  late InstagramModel? instagramModel;
  @override
  void initState() {
    super.initState();
    instagramModel = widget.instagramModel;
  }

  @override
  Widget build(BuildContext context) {
    if (instagramModel != null) {
      Logger.i('SingleChildScrollView');
      return SingleChildScrollView(
        child: Column(
          children: [
            SelectionSlider(
              plan: instagramModel!.likes,
            ),
          ],
        ),
      );
    }
    Logger.i('Container');
    return Container();
  }
}
