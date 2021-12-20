// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstagramPost _$InstagramPostFromJson(Map<String, dynamic> json) =>
    InstagramPost(
      shortcode: json['shortcode'] as String,
      thumbnailSrc: json['thumbnail_src'] as String,
    );

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      hasNextPage: json['has_next_page'] as bool?,
      endCursor: json['end_cursor'] as String?,
    );
