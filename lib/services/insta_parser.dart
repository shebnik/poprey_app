library insta_parser;

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';

class InstaParser {
  static List<String> lastPostsParsed = [];
  static Map<String, String> lastUserDataParsed = <String, String>{};
  static Map<String, String> lastPhotoUrlsParsed = <String, String>{};
  static String lastVideoUrlParsed = '';

  /// Returns the first 12 posts of a public Instagram profile and also saves it on `lastPostsParsed`.
  static Future<List<String>> postsUrlsFromProfile(String? profileUrl) async {
    if (profileUrl == null || profileUrl == '') {
      return [];
    }

    String _profilePageData;
    String _temporaryProfileData;
    List<String> _postsUrls = [];
    Client _client = Client();
    Response _response;
    var _elements;
    var _document;

    try {
      _response = await _client.get(Uri.parse(profileUrl));
      _document = parse(_response.body);
      _elements = _document.querySelectorAll('body');
    } catch (error) {
      print('[InstaParser] [ParsePostsUrlsFromInstaProfile] ERROR: $error');
    }

    _profilePageData = _elements[0].text;

    // Step 2 - Get postsUrl (shortcode tag)
    _temporaryProfileData = _profilePageData;
    for (int i = 0; i < 12; i++) {
      int _inx;
      int _urlLenght;
      String _postUrl;

      _postsUrls.add('');
      _inx = _temporaryProfileData.indexOf("shortcode\":\"");
      _urlLenght = 11; //ex: BxFcM54hJMb
      _inx += "shortcode\":\"".length; // Advance
      _postUrl = _temporaryProfileData
          .substring(_inx)
          .substring(0, _urlLenght); // Gets the postUrl
      _postsUrls[i] =
          "https://www.instagram.com/p/$_postUrl"; // Adds to the postsUrls list
      _temporaryProfileData =
          _temporaryProfileData.substring(_inx); // Cuts the read shortcode

      //print('[InstaParser] [ParsePostsUrlsFromInstaProfile] #$i _postUrl: ${_postsUrls[i]}');
    }
    lastPostsParsed = _postsUrls;
    return _postsUrls;
  }

  /// Returns the video url of a post if it exists or empty string if it doesn't or the profile is private
  /// and also saves it on `lastVideoUrlParsed`.
  static Future<String> videoUrlFromPost(String? postUrl) async {
    if (postUrl == null || postUrl == '') return '';

    String _profilePageData;
    String _temporaryProfileData;
    String _videoUrl = '';
    List<String> _videosUrls = [];
    Client _client = Client();
    Response _response;
    var _elements;
    int _endInx;

    try {
      _response = await _client.get(Uri.parse(postUrl));
      var _document = parse(_response.body);
      _elements = _document.querySelectorAll('body');
    } catch (error) {
      print('[InstaParser] [ParseVideoUrlFromInstaPost] ERROR: $error');
    }

    _profilePageData = _elements[0].text;

    // Step 2 - Get videoUrl (video_url tag)
    _temporaryProfileData = _profilePageData;
    _endInx =
        _temporaryProfileData.indexOf("mp4?_nc_ht=scontent.cdninstagram.com");

    if (_endInx > -1) {
      // If found
      int _startInx;
      _endInx += "mp4?_nc_ht=scontent.cdninstagram.com".length; // Advance
      _startInx = _temporaryProfileData.indexOf("video_url\":\""); //Search
      _startInx += "video_url\":\"".length; // Advance
      _videoUrl = _temporaryProfileData
          .substring(_startInx)
          .substring(0, _endInx - _startInx); // Gets the videoUrl
      _videosUrls.add(_videoUrl); // Adds to the postsUrl list
      _temporaryProfileData =
          _temporaryProfileData.substring(_startInx); // Cuts the read src
    } //print('[ReportsPage] [ParseVideoUrlFromInstaPost] _videoUrl: $_videoUrl');

    lastVideoUrlParsed = _videoUrl;
    return _videoUrl;
  }

  /// Returns urls for `small`, `medium` and `large` size of photos if it's not from a private profile.
  /// Also saves it on `lastPhotoUrlsParsed`.
  static Future<Map<String, String>> photoUrlsFromPost(String? postUrl) async {
    if (postUrl == null || postUrl == '') return <String, String>{};

    Map<String, String> _photosAllSizes = <String, String>{};

    if (postUrl[postUrl.length - 1] == '/') {
      _photosAllSizes['small'] = postUrl + 'media/?size=t';
      _photosAllSizes['medium'] = postUrl + 'media/?size=m';
      _photosAllSizes['large'] = postUrl + 'media/?size=l';
    } else {
      _photosAllSizes['small'] = postUrl + '/media/?size=t';
      _photosAllSizes['medium'] = postUrl + '/media/?size=m';
      _photosAllSizes['large'] = postUrl + '/media/?size=l';
    }

    lastPhotoUrlsParsed = _photosAllSizes;
    return _photosAllSizes;
  }

  /// Returns urls `biography`, `followersCount`, `followingsCount`, `fullName`,
  /// `isPrivate`, `isVerified`, `profilePicUrl`, `profilePicUrlHd`, `username` and `postsCount`.
  /// Also saves it on `lastUserDataParsed`.
  static Future<Map<String, String>> userDataFromProfile(
      String? profileUrl) async {
    if (profileUrl == null || profileUrl == '') {
      return <String, String>{};
    }

    Client _client = Client();
    Response _response;
    Document _document;
    List<Element> _elements = [];
    String _profilePageData = '';
    String _temporaryProfileData = '';

    int _startInx = 0;
    int _endInx = 1;

    String _biography = '';
    String _biographyPatternStart = "biography\":\"";
    String _biographyPatternEnd = "\",\"blocked_by_viewer\":";

    String _followersCount = '';
    String _followersCountPatternStart = "edge_followed_by\":{\"count\":";
    String _followersCountPatternEnd = "},\"followed_by_viewer\":";

    String _followingsCount = '';
    String _followingsCountPatternStart = 'edge_follow":{"count":';
    String _followingsCountPatternEnd = '},"follows_viewer":';

    String _fullName = '';
    String _fullNamePatternStart = "full_name\":\"";
    String _fullNamePatternEnd = "\",\"has_channel\":";

    String _isPrivate = '';
    String _isPrivatePatternStart = "is_private\":";
    String _isPrivatePatternEnd = ",\"is_verified\":";

    String _isVerified = '';
    String _isVerifiedPatternStart = "is_verified\":";
    String _isVerifiedPatternEnd = ",\"edge_mutual_followed_by\":";

    String _profilePicUrl = '';
    String _profilePicUrlPatternStart = "profile_pic_url\":\"";
    String _profilePicUrlPatternEnd =
        "jpg?_nc_ht=instagram.fsdu5-1.fna.fbcdn.net";

    String _profilePicUrlHd = '';
    String _profilePicUrlHdPatternStart = "profile_pic_url_hd\":\"";
    String _profilePicUrlHdPatternEnd =
        "jpg?_nc_ht=instagram.fsdu5-1.fna.fbcdn.net";

    String _username = '';
    String _usernamePatternStart = "username\":\"";
    String _usernamePatternEnd = "\",\"connected_fb_page\":";

    String _postsCount = '';
    String _postsCountPatternStart =
        "edge_owner_to_timeline_media\":{\"count\":";
    String _postsCountPatternEnd = ",\"page_info\":{";

    Map<String, String> _userData = <String, String>{};

    try {
      _response = await _client.get(Uri.parse(profileUrl));
      _document = parse(_response.body);
      _elements = _document.querySelectorAll('body');
    } catch (error) {
      print('[InstaParser] [ParsePostsUrlsFromInstaProfile] ERROR: $error');
    }

    _profilePageData = _elements[0].text;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_biographyPatternStart) +
        _biographyPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_biographyPatternEnd);
    _biography = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['biography'] = _biography;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_followersCountPatternStart) +
        _followersCountPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_followersCountPatternEnd);
    _followersCount = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['followersCount'] = _followersCount;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_followingsCountPatternStart) +
        _followingsCountPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_followingsCountPatternEnd);
    _followingsCount = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['followingsCount'] = _followingsCount;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_fullNamePatternStart) +
        _fullNamePatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_fullNamePatternEnd);
    _fullName = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['fullName'] = _fullName;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_isPrivatePatternStart) +
        _isPrivatePatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_isPrivatePatternEnd);
    _isPrivate = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['isPrivate'] = _isPrivate;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_isVerifiedPatternStart) +
        _isVerifiedPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_isVerifiedPatternEnd);
    _isVerified = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['isVerified'] = _isVerified;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_profilePicUrlPatternStart) +
        _profilePicUrlPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_profilePicUrlPatternEnd) +
        _profilePicUrlPatternEnd.length;
    _profilePicUrl = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['profilePicUrl'] = _profilePicUrl;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_profilePicUrlHdPatternStart) +
        _profilePicUrlHdPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_profilePicUrlHdPatternEnd) +
        _profilePicUrlHdPatternEnd.length;
    _endInx =
        _temporaryProfileData.indexOf(_profilePicUrlHdPatternEnd, _endInx) +
            _profilePicUrlHdPatternEnd.length;
    _profilePicUrlHd = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['profilePicUrlHd'] = _profilePicUrlHd;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_usernamePatternStart) +
        _usernamePatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_usernamePatternEnd);
    _username = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['username'] = _username;

    _temporaryProfileData = _profilePageData;
    _startInx = _temporaryProfileData.indexOf(_postsCountPatternStart) +
        _postsCountPatternStart.length;
    _endInx = _temporaryProfileData.indexOf(_postsCountPatternEnd) +
        _postsCountPatternEnd.length;
    _endInx = _temporaryProfileData.indexOf(_postsCountPatternEnd, _endInx);
    _postsCount = _temporaryProfileData
        .substring(_startInx)
        .substring(0, _endInx - _startInx);
    _userData['postsCount'] = _postsCount;

    lastUserDataParsed = _userData;
    return _userData;
  }
}
