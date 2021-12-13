import 'package:flutter/material.dart';
import 'package:poprey_app/models/plans/instagram.dart';
import 'package:poprey_app/services/plans_parser.dart';
import 'package:poprey_app/utils/app_theme.dart';
import 'package:poprey_app/ui/widgets/widgets.dart';
import 'package:poprey_app/utils/utils.dart';

class InstagramPlans extends StatefulWidget {
  const InstagramPlans({Key? key}) : super(key: key);

  @override
  _InstagramPlansState createState() => _InstagramPlansState();
}

class _InstagramPlansState extends State<InstagramPlans>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late Future<Map?> _getInstaPlans;
  late Instagram instagramPlans;
  TabController? _tabController;
  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_plans';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController!.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _getInstaPlans = PlansParser().getInstaPlans();

    _tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    _tabController!.addListener(() {
      setState(() {
        tabIndex.value = _tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Utils.futureWidget(
      future: _getInstaPlans,
      onDidInitialize: (context, snapshot) {
        instagramPlans = Instagram.fromJson(snapshot.data);
        return instaPlans();
      },
    );

    // return FutureBuilder(
    //   future: _getInstaPlans,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       instagramPlans = Instagram.fromJson(snapshot.data);
    //       return instaPlans();
    //     } else if (snapshot.hasError) {
    //       return UI.errorIcon;
    //     } else {
    //       return UI.loading;
    //     }
    //   },
    // );
  }

  Widget instaPlans() {
    return Expanded(
      child: Scaffold(
        appBar: appBar(),
        body: TabBarView(
          controller: _tabController,
          children: plansWidgets(),
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: tabBar(),
        ),
      ),
      preferredSize: const Size.fromHeight(50),
    );
  }

  Widget tabBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelStyle: Widgets.getTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppTheme.primary,
        ),
        unselectedLabelStyle: Widgets.getTextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        indicatorColor: AppTheme.primary,
        labelColor: AppTheme.primary,
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 30),
        tabs: const [
          Tab(text: 'Likes'),
          Tab(text: 'Followers'),
          Tab(text: 'Auto-Likes'),
          Tab(text: 'Views'),
          Tab(text: 'Comments'),
        ],
      ),
    );
  }

  List<Widget> plansWidgets() {
    List<Widget> plans = [
      listPlan(instagramPlans.likes, 'likes'),
      listPlan(instagramPlans.followers, 'followers'),
      listPlan(instagramPlans.autoLikesPost, 'autoLikesPost'),
      listPlan(instagramPlans.views, 'views'),
      listPlan(instagramPlans.comments, 'comments'),
    ];

    return plans;
  }

  Widget listPlan(List<Plan> plan, String planName) {
    return GridView.builder(
      itemCount: plan.length,
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio:
            MediaQuery.of(context).orientation == Orientation.landscape
                ? 1200 /
                    (MediaQuery.of(context).size.width)
                : MediaQuery.of(context).size.height / 1000,
      ),
      itemBuilder: (BuildContext context, int index) {
        return cardItem(plan[index], planName);
      },
    );
  }
}

Widget cardItem(Plan plan, name) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: AppTheme.chip,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                Widgets.text(
                  text: plan.count.toString(),
                  fontSize: 20,
                ),
                Widgets.text(
                  text: name,
                ),
              ],
            ),
          ),
          Widgets.divider,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Widgets.text(
              text: '\$${plan.price.toString()} 0',
              color: AppTheme.lightBlue,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Widgets.elevatedButton(
              onPressed: () => {},
              child: Widgets.text(text: 'Buy Now', color: Colors.white),
              rounded: true,
            ),
          ),
        ],
      ),
    ),
  );
}
