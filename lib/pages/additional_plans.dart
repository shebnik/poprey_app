import 'package:flutter/material.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/utils/widgets.dart';

class AdditionalPlans extends StatefulWidget {
  const AdditionalPlans({Key? key}) : super(key: key);

  @override
  _AdditionalPlansState createState() => _AdditionalPlansState();
}

class _AdditionalPlansState extends State<AdditionalPlans> {

  late Future<Map?> _getAdditionalPlans;

  @override
  void initState() {
    _getAdditionalPlans = PlansParser().getAdditionalPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getAdditionalPlans,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Widgets.doneIcon;
          } else if (snapshot.hasError) {
            return const Icon(Icons.error_outline);
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
