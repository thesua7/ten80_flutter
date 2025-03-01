import 'package:get/get.dart';
import '../data/models/photo_model.dart';
import '../data/repositories/photo_repository.dart';
import '../../services/storage_service.dart';

class HomeController extends GetxController {
  final PhotoRepository _photoRepository = PhotoRepository();
  final StorageService _storageService = Get.find<StorageService>();

  var selectedIndex = 0.obs;


  var photos = <PhotoModel>[].obs;


  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 1.obs;
  var hasMoreData = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPhotos();
  }

  Future<void> fetchPhotos({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      hasMoreData.value = true;
    }

    if (!hasMoreData.value && !isRefresh) return;

    try {
      isLoading.value = true;
      hasError.value = false;

      final newPhotos = await _photoRepository.getPhotos(
        page: currentPage.value,
        perPage: 30,
      );

      if (isRefresh) {
        photos.value = newPhotos;
      } else {
        photos.addAll(newPhotos);
      }

      if (newPhotos.isEmpty || newPhotos.length < 30) {
        hasMoreData.value = false;
      } else {
        currentPage.value++;
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPhotos() async {
    await fetchPhotos(isRefresh: true);
  }

  bool isFavorite(String photoId) {
    return _storageService.isFavorite(photoId);
  }

  void toggleFavorite(String photoId) {
    if (isFavorite(photoId)) {
      _storageService.removeFavorite(photoId);
    } else {
      _storageService.saveFavorite(photoId);
    }
    photos.refresh();

  }

  // Get only favorite photos
  List<PhotoModel> getFavoritePhotos() {
    return photos.where((photo) => isFavorite(photo.id)).toList();
  }

  // Change selected index for bottom navigation
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}