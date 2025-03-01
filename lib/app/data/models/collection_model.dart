import 'package:ten80/app/data/models/photo_model.dart';
import 'package:ten80/app/data/models/user_model.dart';

class CollectionModel {
  final String id;
  final String title;
  final String? description;
  final int totalPhotos;
  final List<PhotoModel>? previewPhotos;
  final UserModel? user;

  CollectionModel({
    required this.id,
    required this.title,
    this.description,
    required this.totalPhotos,
    this.previewPhotos,
    this.user,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    List<PhotoModel>? previewPhotos;

    if (json['preview_photos'] != null) {
      previewPhotos = List<PhotoModel>.from(
        json['preview_photos'].map((x) => PhotoModel.fromJson(x)),
      );
    }

    return CollectionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      totalPhotos: json['total_photos'],
      previewPhotos: previewPhotos,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}