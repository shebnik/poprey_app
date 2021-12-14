import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/ui/widgets/selection_slider/selection_slider.dart';
import 'package:poprey_app/utils/logger.dart';

class InstagramTab extends StatefulWidget {
  const InstagramTab({Key? key}) : super(key: key);

  @override
  _InstagramTabState createState() => _InstagramTabState();
}

class _InstagramTabState extends State<InstagramTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) => SelectionSlider(),
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }
}
