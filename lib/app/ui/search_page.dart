
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ten80/app/ui/widgets/custom_widgets.dart';

import '../controllers/home_controller.dart';
import '../controllers/search_controller.dart';


class SearchPage extends GetView<SearchController1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search wallpapers...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: controller.onSearchQueryChanged,
        ),
      ),
      body: Obx(
            () {
          if (controller.hasError.value) {
            return ErrorDisplayWidget(
              message: controller.errorMessage.value,
              onRetry: () => controller.searchPhotos(isNewSearch: true),
            );
          }

          if (controller.searchQuery.isEmpty) {
            return const Center(
              child: Text('Type something to search for wallpapers'),
            );
          }

          if (controller.photos.isEmpty && !controller.isLoading.value) {
            return const Center(
              child: Text('No wallpapers found'),
            );
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                  !controller.isLoading.value &&
                  controller.hasMoreData.value) {
                controller.searchPhotos();
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
              itemCount: controller.photos.length +
                  (controller.isLoading.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= controller.photos.length) {
                  return const LoadingWidget();
                }

                final photo = controller.photos[index];

                return PhotoCard(
                  photo: photo,
                  onTap: () => Get.toNamed(
                    '/detail',
                    arguments: {'photoId': photo.id},
                  ),
                  isFavorite: Get.find<HomeController>().isFavorite(photo.id),
                  onFavoriteToggle: () => Get.find<HomeController>().toggleFavorite(photo.id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}