import 'package:get/get.dart';
import '../data/models/photo_model.dart';
import '../data/repositories/photo_repository.dart';
import '../../services/storage_service.dart';
import '../../services/wallpaper_service.dart';

class DetailController extends GetxController {
  final PhotoRepository _photoRepository = PhotoRepository();
  final StorageService _storageService = Get.find<StorageService>();
  final WallpaperService _wallpaperService = Get.find<WallpaperService>();

  var photoId = ''.obs;
  var photo = Rxn<PhotoModel>();
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var isDownloading = false.obs;
  var isSettingWallpaper = false.obs;

  @override
  void onInit() {
    super.onInit();
    photoId.value = Get.arguments['photoId'];
    fetchPhotoDetails();
  }

  Future<void> fetchPhotoDetails() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      photo.value = await _photoRepository.getPhotoById(photoId.value);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  bool isFavorite() {
    return _storageService.isFavorite(photoId.value);
  }

  void toggleFavorite() {
    if (isFavorite()) {
      _storageService.removeFavorite(photoId.value);
    } else {
      _storageService.saveFavorite(photoId.value);
    }
    update(); // Update UI
  }

  Future<void> downloadAndSetWallpaper(int wallpaperType) async {
    if (photo.value == null) return;

    try {
      isSettingWallpaper.value = true;

      // First download the wallpaper
      isDownloading.value = true;
      final filePath = await _wallpaperService.downloadWallpaper(
        photo.value!.urls.full,
        photo.value!.id,
      );
      isDownloading.value = false;

      // Then set it as wallpaper
      // await _wallpaperService.setWallpaper(filePath, wallpaperType);

      Get.snackbar(
        'Success',
        'Wallpaper set successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to set wallpaper: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSettingWallpaper.value = false;
    }
  }
}