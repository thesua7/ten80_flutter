
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'storage_service.dart';

class WallpaperService extends GetxService {
  final Dio _dio = Dio();
  final StorageService _storageService = Get.find<StorageService>();

  // Download wallpaper
  Future<String> downloadWallpaper(String imageUrl, String photoId) async {
    try {
      // Request storage permission
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission not granted');
      }

      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      final savePath = '${directory.path}/$photoId.jpg';

      // Download the file
      await _dio.download(imageUrl, savePath);

      // Save to downloaded list
      await _storageService.saveDownloadedWallpaper(photoId);

      return savePath;
    } catch (e) {
      throw Exception('Failed to download wallpaper: $e');
    }
  }

  // Set wallpaper
  // Future<bool> setWallpaper(String filePath, int wallpaperType) async {
  //   try {
  //     await WallpaperManagerFlutter().setwallpaperfromFile(
  //       filePath,
  //       wallpaperType,
  //     );
  //     return true; // Assume success if no exception is thrown
  //   } on PlatformException catch (e) {
  //     throw Exception('Failed to set wallpaper: ${e.message}');
  //   }
  // }

}