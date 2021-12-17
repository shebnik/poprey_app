// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instagram_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstagramProfile _$InstagramProfileFromJson(Map<String, dynamic> json) =>
    InstagramProfile(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String,
      isPrivate: json['is_private'] as bool,
      profilePicUrl: json['profile_pic_url_hd'] as String,
      followers:
          followersFromJson(json['edge_followed_by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstagramProfileToJson(InstagramProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'full_name': instance.fullName,
      'is_private': instance.isPrivate,
      'profile_pic_url_hd': instance.profilePicUrl,
      'edge_followed_by': instance.followers,
    };
