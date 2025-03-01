import 'package:ten80/app/data/models/user_model.dart';

class PhotoModel {
  final String id;
  final String? createdAt;
  final String? updatedAt;
  final int? width;
  final int? height;
  final String? color;
  final String? blurHash;
  final int? likes;
  final bool? likedByUser;
  final String? description;
  final UserModel? user;
  final PhotoUrls urls;

  PhotoModel({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.likes,
    this.likedByUser,
    this.description,
    this.user,
    required this.urls,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      width: json['width'],
      height: json['height'],
      color: json['color'],
      blurHash: json['blur_hash'],
      likes: json['likes'],
      likedByUser: json['liked_by_user'],
      description: json['description'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      urls: PhotoUrls.fromJson(json['urls']),
    );
  }
}

class PhotoUrls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  PhotoUrls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });

  factory PhotoUrls.fromJson(Map<String, dynamic> json) {
    return PhotoUrls(
      raw: json['raw'],
      full: json['full'],
      regular: json['regular'],
      small: json['small'],
      thumb: json['thumb'],
    );
  }
}