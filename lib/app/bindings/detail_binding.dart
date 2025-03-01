// app/bindings/detail_binding.dart
import 'package:get/get.dart';
import '../controllers/detail_controller.dart';
import '../../services/storage_service.dart';
import '../../services/wallpaper_service.dart';

class DetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(() => DetailController());

    // Make sure services are available
    if (!Get.isRegistered<StorageService>()) {
      Get.putAsync(() => StorageService().init());
    }

    if (!Get.isRegistered<WallpaperService>()) {
      Get.put(WallpaperService());
    }
  }
}