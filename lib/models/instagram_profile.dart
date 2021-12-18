import 'package:json_annotation/json_annotation.dart';

part 'instagram_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class InstagramProfile {
  final String id;
  final String username;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  @JsonKey(name: 'profile_pic_url_hd')
  final String profilePicUrl;

  final String? email;

  @JsonKey(
    name: 'edge_followed_by',
    fromJson: followersFromJson,
    toJson: followersToJson,
  )
  final int followers;

  InstagramProfile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
    required this.followers,
    this.email,
  });

  factory InstagramProfile.fromJson(Map<String, dynamic> json) =>
      _$InstagramProfileFromJson(json);

  Map<String, dynamic> toJson() => _$InstagramProfileToJson(this);

  @override
  String toString() {
    return 'InstagramProfile(id: $id, username: $username, fullName: $fullName, isPrivate: $isPrivate, profilePicUrl: $profilePicUrl)';
  }
}

@override
int followersFromJson(Map<String, dynamic> json) {
  return json['count'];
}

@override
Map<String, dynamic> followersToJson(int object) {
  return {
    'edge_followed_by': {
      'count': object,
    }
  };
}