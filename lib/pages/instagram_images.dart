import 'package:flutter/material.dart';
import 'package:poprey_app/services/insta_parser.dart';

class InstagramWidget extends StatefulWidget {
  const InstagramWidget({Key? key}) : super(key: key);

  @override
  _InstagramWidgetState createState() => _InstagramWidgetState();
}

class _InstagramWidgetState extends State<InstagramWidget> {
  List<Widget> _parsedWidgets = [];

  @override
  void initState() {
    fetchInstaImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //future: fetchInstaImages("shebalinik"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView(
          children: _parsedWidgets,
        );
      },
    );
  }


  Future<void> fetchInstaImages() async {
    List<Widget> _widgetsList = [];
    List<String> _imagesList = [];
    List<String> _postsUrls = await InstaParser.postsUrlsFromProfile(
        'https://www.instagram.com/coderbau');

    if (_postsUrls != null) {
      Map<String, String> photosUrls = new Map<String, String>();
      for (var item in _postsUrls) {
        Map<String, String> photosUrls =
        await InstaParser.photoUrlsFromPost(item);

        var smallimage = photosUrls['small'];

        if (smallimage != null) {
          _widgetsList.add(Image.network(photosUrls['small']!));
        }
      }
      setState(() => _parsedWidgets = _widgetsList);
    }
  }
}
