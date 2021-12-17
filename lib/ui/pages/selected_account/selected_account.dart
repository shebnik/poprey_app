import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poprey_app/ui/pages/selected_account/selected_account_controller.dart';
import 'package:poprey_app/ui/widgets/future_widget.dart';

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
      body: FutureWidget(
        future: controller.fetchUserProfile(),
        onDidInitialize: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView();
        },
      ),
    );
  }

  Future<void> fetchInstaImages() async {
    // List<Widget> _widgetsList = [];
    // List<String>? _postsUrls = await InstaParser.postsUrlsFromProfile(
    //     'https://www.instagram.com/');

    // if (_postsUrls != null) {
    //   for (var item in _postsUrls) {
    //     Map<String, String> photosUrls =
    //         await InstaParser.photoUrlsFromPost(item);

    //     var smallimage = photosUrls['small'];

    //     if (smallimage != null) {
    //       _widgetsList.add(Image.network(photosUrls['small']!));
    //     }
    //   }
    //   setState(() => _parsedWidgets = _widgetsList);
    // }
  }
}
