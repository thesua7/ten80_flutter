import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../services/storage_service.dart';
import '../../services/wallpaper_service.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());

    // Make sure services are available
    if (!Get.isRegistered<StorageService>()) {
      Get.putAsync(() => StorageService().init());
    }

    if (!Get.isRegistered<WallpaperService>()) {
      Get.put(WallpaperService());
    }
  }
}



