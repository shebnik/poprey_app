import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poprey_app/models/plans/instagram.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/utils/app_colors.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:poprey_app/utils/ui.dart';

class InstagramPlans extends StatefulWidget {
  const InstagramPlans({Key? key}) : super(key: key);

  @override
  _InstagramPlansState createState() => _InstagramPlansState();
}

class _InstagramPlansState extends State<InstagramPlans> {
  late Future<Map?> _getInstaPlans;
  Instagram? instagramPlans;

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
            instagramPlans = Instagram.fromJson(snapshot.data);
            return test();
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget test() {
    if (instagramPlans == null) return UI.loading;
    List<Plan> likes = instagramPlans!.likes;
    return ListView.builder(
      itemCount: likes.length,
      itemBuilder: (BuildContext context, int index) {
        return cardItem(likes[index], "Likes");
      },
    );
  }

  Widget cardItem(Plan plan, name) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  UI.text(
                    text: plan.count.toString(),
                    fontWeight: FontWeight.bold,
                  ),
                  UI.text(
                    text: name,
                  ),
                ],
              ),
            ),
            UI.divider,
            Padding(
              padding: EdgeInsets.all(30),
              child: UI.text(
                text: "\$" + plan.price.toString(),
                color: AppColors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
