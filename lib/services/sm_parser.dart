import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:poprey_app/models/selected_plan_model.dart';

import 'package:poprey_app/utils/logger.dart';

class SmParser {
  static const tikTokApi = 'https://www.tiktok.com/node/share/video/';

  static Future<SmUrlModel?> fetchUrl(
      String url, SelectedPlan selectedPlan) async {
    url = Uri.parse(url).host == '' ? 'https://' + url : url;
    switch (selectedPlan.platform.toLowerCase()) {
      case 'youtube':
        return await fetchMetadata(url);
      case 'tiktok':
        return fetchMetadata(url);
        // return selectedPlan.countInfo == 'Followers'
        //     ? await fetchMetadata(url)
        //     : await fetchTikTokVideo(url);
      case 'spotify':
      case 'facebook':
      case 'vk':
        return await fetchMetadata(url);
      case 'twitter':
        return await fetchMetadata(url);
      default:
        return null;
    }
  }

  static String getTikTokVideo(String url) {
    return url
        .substring(url.indexOf('tiktok.com/') + 11)
        .replaceAll('/video', '');
  }

  static Future<SmUrlModel?> fetchTikTokVideo(String url) async {
    try {
      final response =
          await http.get(Uri.parse(tikTokApi + getTikTokVideo(url)));
      final model = SmUrlModel.fromTikTok(response.body);
      Logger.i('[SmParser] fetchTikTokVideo - ${model.toString()}');
      return model;
    } catch (e) {
      Logger.e('[SmParser] fetchTikTokVideo - error', e);
    }
  }

  static Future<SmUrlModel?> fetchMetadata(String url) async {
    final metadata = await MetadataFetch.extract(url);
    if (metadata == null) return null;
    return SmUrlModel.fromMetadata(metadata);
  }
}

class SmUrlModel {
  final String? title;
  final String? image;

  SmUrlModel({
    this.title,
    this.image,
  });

  factory SmUrlModel.fromMetadata(Metadata metadata) {
    return SmUrlModel(title: metadata.title, image: metadata.image);
  }

  factory SmUrlModel.fromTikTok(String source) {
    final data = jsonDecode(source);
    return SmUrlModel(
      title: data['itemInfo']['itemStruct']['desc'] ?? '',
      image: data['itemInfo']['itemStruct']['video']['cover'] ?? '',
    );
  }

  @override
  String toString() => 'SmUrlModel(title: $title, thumbnailUrl: $image)';
}
