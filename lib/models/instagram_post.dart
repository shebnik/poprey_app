import 'package:json_annotation/json_annotation.dart';

part 'instagram_post.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class InstagramPost {
  final String shortcode;

  @JsonKey(name: 'thumbnail_src')
  final String thumbnailSrc;

  InstagramPost({
    required this.shortcode,
    required this.thumbnailSrc,
  });

  factory InstagramPost.fromJson(Map<String, dynamic> json) =>
      _$InstagramPostFromJson(json);

  @override
  String toString() =>
      'InsagramPost(shortcode: $shortcode, thumbnailSrc: $thumbnailSrc)';
}

@JsonSerializable(explicitToJson: true, createToJson: false)
class PageInfo {
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;

  @JsonKey(name: 'end_cursor')
  final String? endCursor;

  PageInfo({
    required this.hasNextPage,
    required this.endCursor,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  @override
  String toString() =>
      'PageInfo(hasNextPage: $hasNextPage, endCursor: $endCursor)';
}
