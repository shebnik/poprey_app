import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account_controller.dart';
import 'package:poprey_app/ui/widgets/bottom_reset_navigation.dart';
import 'package:poprey_app/ui/widgets/future_widget.dart';
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
    controller = Get.put(SelectedAccountController(Get.arguments));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F8FB),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Selected Account',
          style: Theme.of(context).textTheme.headline3!.apply(
                color: AppTheme.primary,
              ),
        ),
      ),
      body: SafeArea(
        child: FutureWidget(
          future: controller.init(),
          onDidInitialize: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) return pageBody();
            return Container();
          },
        ),
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
        NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            var metrics = scrollEnd.metrics;
            // print(metrics);
            if (metrics.atEdge && metrics.pixels != 0) {
              controller.loadMore();
            }
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 22),
                  leading: ClipOval(
                    child: Image.network(
                      controller.profile.profilePicUrl,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    controller.profile.username,
                    style: Theme.of(context).textTheme.headline3!.apply(
                          color: AppTheme.primaryBlue,
                        ),
                  ),
                  subtitle: Text(
                    controller.getFollowers,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                ),
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
          ),
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
      ],
    );
  }

  Widget postsGrid() {
    return GridView.builder(
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
    );
  }
}
