import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    _box = GetStorage();
    return this;
  }

  // Save a favorite photo
  Future<void> saveFavorite(String photoId) async {
    List<String> favorites = getFavorites();
    if (!favorites.contains(photoId)) {
      favorites.add(photoId);
      await _box.write('favorites', favorites);
    }
  }

  // Remove a photo from favorites
  Future<void> removeFavorite(String photoId) async {
    List<String> favorites = getFavorites();
    favorites.remove(photoId);
    await _box.write('favorites', favorites);
  }

  // Get all favorite photos
  List<String> getFavorites() {
    return (_box.read<List>('favorites') ?? []).cast<String>();
  }

  // Check if a photo is a favorite
  bool isFavorite(String photoId) {
    return getFavorites().contains(photoId);
  }

  // Save downloaded wallpaper
  Future<void> saveDownloadedWallpaper(String photoId) async {
    List<String> downloads = getDownloads();
    if (!downloads.contains(photoId)) {
      downloads.add(photoId);
      await _box.write('downloads', downloads);
    }
  }

  // Get all downloaded wallpapers
  List<String> getDownloads() {
    return (_box.read<List>('downloads') ?? []).cast<String>();
  }
}