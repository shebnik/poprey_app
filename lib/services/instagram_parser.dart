// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart';
import 'package:poprey_app/models/insagram_post.dart';
import 'package:poprey_app/utils/logger.dart';
import 'package:http/http.dart' as http;

class InstagramParser {
  /// GET https://instagram.com/graphql/query/?query_id=17888483320059182&variables={"id":"","first":20,"after":null}
  /// Where:
  /// query_id - permanent value: 17888483320059182 (note it might be changed in future).
  /// id - id of the user. It may come with list of users. To get the list of users you can use following request:
  /// GET https://www.instagram.com/web/search/topsearch/?context=blended&query=YOUR_QUERY
  /// first - amount of items to get.
  /// after - id of the last item if you want to get items from that id.

  // static const INSTAGRAM_USERNAME = 'poprey_app';
  // static const INSTAGRAM_PASSWORD = '5xL3Ek[d6gU,M2`K';

  static const QUERY_ID = '17888483320059182';
  static const POSTS_BASE_URL = 'https://instagram.com/graphql/query/';
  static const USERS_BASE_URL =
      'https://www.instagram.com/web/search/topsearch/?context=blended';

  static String getPostsQueryUrl({
    required String id,
    required int count,
    String? after,
  }) {
    return POSTS_BASE_URL +
        '?query_id=$QUERY_ID&variables={"id":"$id","first":$count,"after":"$after"}';
  }

  static String getUsersQueryUrl(String username) =>
      USERS_BASE_URL + '&query=$username';

  static String getProfileUrl(String username) =>
      'https://www.instagram.com/' + username.trim() + '/?__a=1';

  static final Map<String, String> headers = {
    // 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36',
    'User-Agent': 'python-requests/2.26.0',
    'Accept-Encoding': 'gzip, deflate',
    'Accept': '*/*',
    'Connection': 'keep-alive',
    'cookie':
        'csrftoken=k1MQxsmhQK8IbdUIlEUCI3HY6dsrdQPn; ds_user_id=50798602235; sessionid=50798602235%3ApDlCcBxd3sIvL6%3A5;'
  };

  static Future<Response> getInsagramRequest(String url) async {
    return http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: headers,
    );
  }

  static Future<Map<String, dynamic>?> fetchInstagramProfile(
      String username) async {
    try {
      String url = getProfileUrl(username);
      var response = await getInsagramRequest(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData.isNotEmpty) {
        final data = extractedData['graphql']['user'] as Map<String, dynamic>;
        return data;
      }
    } catch (e) {
      Logger.e('[InstagramParser] getInstagramProfile error', e);
    }
  }

  static Future<Map<String, dynamic>?> fetchInsagramPosts(
      String id, PageInfo pageInfo) async {
    if (pageInfo.hasNextPage == false) return null;
    try {
      final url = getPostsQueryUrl(
        id: id,
        count: 12,
        after: pageInfo.endCursor,
      );
      var response = await getInsagramRequest(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'ok') {
        return data['data']['user']['edge_owner_to_timeline_media']
            as Map<String, dynamic>;
      }
    } catch (e) {
      Logger.e('[InstagramParser] getPosts error', e);
    }
  }

  static bool isPrivateProfile(Map<String, dynamic> insagramUser) {
    return insagramUser['is_private'] as bool;
  }
}
