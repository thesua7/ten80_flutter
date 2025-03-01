import 'package:dio/dio.dart';

import '../models/photo_model.dart';
import '../providers/api_provider.dart';

class PhotoRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<PhotoModel>> getPhotos({
    int page = 1,
    int perPage = 30,
    String orderBy = 'latest',
  }) async {
    try {
      final Response response = await _apiProvider.getPhotos(
        page: page,
        perPage: perPage,
        orderBy: orderBy,
      );

      return (response.data as List)
          .map((data) => PhotoModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }

  Future<List<PhotoModel>> searchPhotos({
    required String query,
    int page = 1,
    int perPage = 30,
  }) async {
    try {
      final Response response = await _apiProvider.searchPhotos(
        query: query,
        page: page,
        perPage: perPage,
      );

      return (response.data['results'] as List)
          .map((data) => PhotoModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to search photos: $e');
    }
  }

  Future<PhotoModel> getPhotoById(String id) async {
    try {
      final Response response = await _apiProvider.getPhotoById(id);
      return PhotoModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load photo details: $e');
    }
  }

  Future<List<PhotoModel>> getRandomPhotos({
    int count = 1,
    List<String>? topics,
  }) async {
    try {
      final Response response = await _apiProvider.getRandomPhotos(
        count: count,
        topics: topics,
      );

      return (response.data as List)
          .map((data) => PhotoModel.fromJson(data))
          .toList();
    } catch (e) {
      throw Exception('Failed to load random photos: $e');
    }
  }
}
