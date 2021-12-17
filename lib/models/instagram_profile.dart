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

  InstagramProfile({
    required this.id,
    required this.username,
    required this.fullName,
    required this.isPrivate,
    required this.profilePicUrl,
  });

  factory InstagramProfile.fromJson(Map<String, dynamic> json) =>
      _$InstagramProfileFromJson(json);

  Map<String, dynamic> toJson() => _$InstagramProfileToJson(this);

  @override
  String toString() {
    return 'InstagramProfile(id: $id, username: $username, fullName: $fullName, isPrivate: $isPrivate, profilePicUrl: $profilePicUrl)';
  }
}
