import 'package:ten80/app/data/models/user_profile_image.dart';

class UserModel {
  final String id;
  final String username;
  final String? name;
  final String? bio;
  final UserProfileImage? profileImage;

  UserModel({
    required this.id,
    required this.username,
    this.name,
    this.bio,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      bio: json['bio'],
      profileImage: json['profile_image'] != null
          ? UserProfileImage.fromJson(json['profile_image'])
          : null,
    );
  }
}