import 'package:dio/dio.dart';
import 'package:ten80/app/utils/api_constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ApiProvider() {
    _dio.options.baseUrl = ApiConstants.baseUrl;
    _dio.options.headers = {
      'Authorization': 'Client-ID ${ApiConstants.accessKey}',
      'Accept-Version': 'v1',
    };
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);

    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> getPhotos({int page = 1, int perPage = 30, String orderBy = 'latest'}) async {
    try {
      final response = await _dio.get(
        '/photos',
        queryParameters: {
          'page': page,
          'per_page': perPage,
          'order_by': orderBy,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchPhotos({required String query, int page = 1, int perPage = 30}) async {
    try {
      final response = await _dio.get(
        '/search/photos',
        queryParameters: {
          'query': query,
          'page': page,
          'per_page': perPage,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getPhotoById(String id) async {
    try {
      final response = await _dio.get('/photos/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getRandomPhotos({int count = 1, List<String>? topics}) async {
    try {
      final Map<String, dynamic> queryParams = {'count': count};
      if (topics != null && topics.isNotEmpty) {
        queryParams['topics'] = topics.join(',');
      }

      final response = await _dio.get(
        '/photos/random',
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
