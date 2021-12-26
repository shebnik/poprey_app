import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:poprey_app/utils/logger.dart';

class SmParser {
  // static String youTubeThumbnailUrl(String id) =>
  //     'https://img.youtube.com/vi/$id/hqdefault.jpg';

  // static String getYouTubeThumbnailUrl(String url) {
  //   if (url.contains('youtu.be')) {
  //     return youTubeThumbnailUrl(
  //         url.substring(url.lastIndexOf('youtu.be/') + 9));
  //   }
  //   return youTubeThumbnailUrl(url.substring(url.lastIndexOf('watch?v=') + 8));
  // }

  static String getVideoID(String url) {
    if (url.contains('youtu.be')) {
      return url.substring(url.indexOf('youtu.be/') + 9);
    }
    return url.substring(url.indexOf('watch?v=') + 8);
  }

  static Future<SmUrlModel?> fetchYouTubeVideo(String url) async {
    final videoID = getVideoID(url);
    try {
      var url = 'https://www.youtube.com/oembed?format=json&url=';
      var videoUri =
          Uri.encodeComponent('https://www.youtube.com/watch?v=$videoID');
      var query = url + videoUri;
      var response = await http.get(Uri.parse(query));
      final model = SmUrlModel.fromJson(response.body);
      Logger.i('[SmParser] fetchYouTubeVideo - ${model.toString()}');
      return model;
    } catch (e) {
      Logger.e('[SmParser] fetchYouTubeVideo - error', e);
    }
  }
}

class SmUrlModel {
  final String title;
  final String thumbnailUrl;

  SmUrlModel({
    required this.title,
    required this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'thumbnail_url': thumbnailUrl,
    };
  }

  factory SmUrlModel.fromMap(Map<String, dynamic> map) {
    return SmUrlModel(
      title: map['title'] ?? '',
      thumbnailUrl: map['thumbnail_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SmUrlModel.fromJson(String source) =>
      SmUrlModel.fromMap(json.decode(source));

  @override
  String toString() => 'SmUrlModel(title: $title, thumbnailUrl: $thumbnailUrl)';
}
