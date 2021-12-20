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
  final bool? isSelected;

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
    this.isSelected,
  });

  factory InstagramProfile.fromJson(Map<String, dynamic> json) =>
      _$InstagramProfileFromJson(json);

  Map<String, dynamic> toJson() => _$InstagramProfileToJson(this);

  @override
  String toString() {
    return 'InstagramProfile(id: $id, username: $username, fullName: $fullName, isPrivate: $isPrivate, profilePicUrl: $profilePicUrl)';
  }

  InstagramProfile copyWith({
    String? id,
    String? username,
    String? fullName,
    bool? isPrivate,
    String? profilePicUrl,
    String? email,
    bool? isSelected,
    int? followers,
  }) {
    return InstagramProfile(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      isPrivate: isPrivate ?? this.isPrivate,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      email: email ?? this.email,
      isSelected: isSelected ?? this.isSelected,
      followers: followers ?? this.followers,
    );
  }
}

@override
int followersFromJson(Map<String, dynamic> json) {
  return json['count'];
}

@override
Map<String, dynamic> followersToJson(int object) {
  return {
    'count': object,
  };
}
