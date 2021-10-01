import 'package:flutter/material.dart';
import 'package:poprey_app/models/plans/instagram.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:poprey_app/utils/ui.dart';

class InstagramPlans extends StatefulWidget {
  const InstagramPlans({Key? key}) : super(key: key);

  @override
  _InstagramPlansState createState() => _InstagramPlansState();
}

class _InstagramPlansState extends State<InstagramPlans> {

  late Future<Map?> _getInstaPlans;

  @override
  void initState() {
    _getInstaPlans = PlansParser().getInstaPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getInstaPlans,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var map = Instagram.fromJson(snapshot.data);
            return UI.doneIcon;
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
