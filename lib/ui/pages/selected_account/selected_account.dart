import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account_controller.dart';
import 'package:poprey_app/ui/widgets/account_tile.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/utils/app_theme.dart';

class SelectedAccount extends StatefulWidget {
  static const routeName = '/selectedAccount';

  const SelectedAccount({
    Key? key,
  }) : super(key: key);

  @override
  _SelectedAccountState createState() => _SelectedAccountState();
}

class _SelectedAccountState extends State<SelectedAccount> {
  late final SelectedAccountController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SelectedAccountController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppTheme.primaryBlue),
        backgroundColor: const Color(0xFFF7F8FB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Selected Account',
          style: Theme.of(context).textTheme.headline3!.apply(
                color: AppTheme.primary,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32 + 50),
          child: AccountTile(
            profile: controller.profile,
            radius: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: pageBody(),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, -10),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12, top: 20),
          child: BottomResetNavigation(
            resetPressed: controller.resetPressed,
            nextPressed: () => controller.nextPressed(context),
          ),
        ),
      ),
    );
  }

  Widget pageBody() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26.0),
                child: Text(
                  'Choose Posts',
                  style: Theme.of(context).textTheme.headline3!.apply(
                        color: AppTheme.primary,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38),
                child: Obx(() => postsGrid()),
              ),
            ],
          ),
          // IgnorePointer(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Container(
          //       height: MediaQuery.of(context).size.height / 3.6,
          //       decoration: const BoxDecoration(
          //         gradient: LinearGradient(
          //           colors: [
          //             Color.fromRGBO(196, 196, 196, 1),
          //             Color.fromRGBO(196, 196, 196, 0),
          //           ],
          //           begin: Alignment.bottomCenter,
          //           end: Alignment.topCenter,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }

  Widget postsGrid() {
    return LoadMore(
      onLoadMore: controller.loadMore,
      isFinish: controller.posts.length >= 48,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.posts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 9,
          mainAxisSpacing: 9,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Obx(() {
            var post = controller.posts[index];
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: GestureDetector(
                onTap: () => controller.postSelected(post),
                child: Stack(
                  children: [
                    Image.network(
                      post.thumbnailSrc,
                    ),
                    if (controller.selectedPosts.contains(post)) ...[
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(4, 4, 4, 0.6),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                controller.count,
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
