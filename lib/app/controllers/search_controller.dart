import 'package:get/get.dart';
import '../data/models/photo_model.dart';
import '../data/repositories/photo_repository.dart';

class SearchController1 extends GetxController {
  final PhotoRepository _photoRepository = PhotoRepository();

  var searchQuery = ''.obs;
  var photos = <PhotoModel>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 1.obs;
  var hasMoreData = true.obs;

  Future<void> searchPhotos({bool isNewSearch = false}) async {
    if (searchQuery.value.isEmpty) return;

    if (isNewSearch) {
      currentPage.value = 1;
      hasMoreData.value = true;
      photos.clear();
    }

    if (!hasMoreData.value && !isNewSearch) return;

    try {
      isLoading.value = true;
      hasError.value = false;

      final newPhotos = await _photoRepository.searchPhotos(
        query: searchQuery.value,
        page: currentPage.value,
        perPage: 30,
      );

      photos.addAll(newPhotos);

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

  void onSearchQueryChanged(String query) {
    searchQuery.value = query;
    if (query.isNotEmpty) {
      searchPhotos(isNewSearch: true);
    } else {
      photos.clear();
    }
  }
}