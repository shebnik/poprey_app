// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:poprey_app/models/insagram_post.dart';
import 'package:poprey_app/models/instagram_profile.dart';
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
      'https://www.instagram.com/' + username.trim() + '/channel/?__a=1';

  static final Map<String, String> _headers = {
    'User-Agent':
        r'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0) Gecko/20100101 Firefox/93.0',
    'Cookie':
        r'csrftoken=KwugFcdUbqWmIw5gafx4XceFqG7lL0iy; mid=YXGdmQAEAAGZ8KAkPxbouItPlKZW;ig_did=B1A4CD44-2BC0-46D6-9EA8-183539CC48D0;rur="ASH\0541626909116\0541666509625:01f790737601ddb28113116c4f532ec31a70ba9eed81c465a824b04048f33062c5ad07d8"; ds_user_id=1626909116; sessionid=1626909116%3ASJKuakuknKMwgK%3A29; shbid="13780\0541626909116\0541666509141:01f7550222f10cb6d3fe921d0365f3c16d488e2b5fa5d8df394a2e22bf77b6e58c651ba9"; shbts="1634973141\0541626909116\0541666509141:01f76d9c1887499197411336f50b5e86b6bd269a7d945cef01282c80c8f395ac42412c0f"'
  };

  static Future<Response> getRequest(String url) async {
    return http.get(
      Uri.parse(Uri.encodeFull(url)),
      headers: _headers,
    );
  }

  static Future<InstagramProfile?> fetchInstagramProfile(
      String username) async {
    try {
      String url = getProfileUrl(username);
      var response = await getRequest(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      if (extractedData.isNotEmpty) {
        var user = extractedData['graphql']['user'] as Map<String, dynamic>;
        final instagramProfile = InstagramProfile.fromJson(user);
        var media = user['edge_owner_to_timeline_media'];

        var pageInfo = PageInfo.fromJson(media['page_info']);

        final edges = media['edges'] as List<dynamic>;
        final posts =
            edges.map((e) => InsagramPost.fromJson(e['node'])).toList();

        return instagramProfile;
      }
    } catch (e) {
      Logger.e('[InstagramParser] getInstagramProfile error', e);
    }
  }

  static Future<List<InsagramPost>?> getPosts(
      String id, PageInfo pageInfo) async {
    if (pageInfo.hasNextPage == false) return null;
    try {
      final url = getPostsQueryUrl(
        id: id,
        count: 20,
        after: pageInfo.endCursor,
      );
      var response = await getRequest(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData['status'] == 'ok') {
        var media = extractedData['data']['user']
            ['edge_owner_to_timeline_media'] as Map<String, dynamic>;

        pageInfo = PageInfo.fromJson(media['page_info']);

        final edges = media['edges'] as List<dynamic>;
        final posts =
            edges.map((e) => InsagramPost.fromJson(e['node'])).toList();
        return posts;
      }
    } catch (e) {
      Logger.e('[InstagramParser] getPosts error', e);
    }
  }
}
