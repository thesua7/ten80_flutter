import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ten80/app/ui/widgets/custom_widgets.dart';

import '../controllers/home_controller.dart';
import '../routes/app_pages.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpaper App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed('/search'),
          ),
        ],
      ),
      body: Obx(
            () {
          // Check the selected index and render corresponding content
          if (controller.selectedIndex.value == 0) {
            // Search Tab (Show photos)
            if (controller.hasError.value) {
              return ErrorDisplayWidget(
                message: controller.errorMessage.value,
                onRetry: controller.refreshPhotos,
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refreshPhotos,
              child: controller.photos.isEmpty && controller.isLoading.value
                  ? const LoadingWidget()
                  : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      !controller.isLoading.value &&
                      controller.hasMoreData.value) {
                    controller.fetchPhotos();
                  }
                  return false;
                },
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.photos.length + (controller.hasMoreData.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= controller.photos.length) {
                      return const LoadingWidget();
                    }

                    final photo = controller.photos[index];

                    return PhotoCard(
                      photo: photo,
                      onTap: () => Get.toNamed(
                        Routes.DETAIL,
                        arguments: {'photoId': photo.id},
                      ),
                      isFavorite: controller.isFavorite(photo.id),
                      onFavoriteToggle: () => controller.toggleFavorite(photo.id),
                    );
                  },
                ),
              ),
            );
          } else {
            // Favorites Tab (Show only favorite photos)
            final favoritePhotos = controller.getFavoritePhotos();
            if (favoritePhotos.isEmpty) {
              return const Center(
                child: Text('No Favorites yet'),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: favoritePhotos.length,
              itemBuilder: (context, index) {
                final photo = favoritePhotos[index];
                return PhotoCard(
                  photo: photo,
                  onTap: () => Get.toNamed(
                    Routes.DETAIL,
                    arguments: {'photoId': photo.id},
                  ),
                  isFavorite: true,
                  onFavoriteToggle: () => controller.toggleFavorite(photo.id),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          onTap: controller.setSelectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
