import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ten80/app/ui/widgets/custom_widgets.dart';
import '../controllers/detail_controller.dart';


class DetailPage extends GetView<DetailController> {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wallpaper Details'),
          actions: [
            Obx(
                  () => IconButton(
                icon: Icon(
                  controller.isFavoriteRx.value ? Icons.favorite : Icons.favorite_border,
                  color: controller.isFavoriteRx.value? Colors.red : null,
                ),
                onPressed: controller.toggleFavorite,
              ),
            ),
          ],
        ),
        body: Obx(
        () {
      if (controller.isLoading.value) {
        return const LoadingWidget();
      }

      if (controller.hasError.value) {
        return ErrorDisplayWidget(
          message: controller.errorMessage.value,
          onRetry: controller.fetchPhotoDetails,
        );
      }

      if (controller.photo.value == null) {
        return const Center(child: Text('No photo found.'));
      }

      return Column(
          children: [
          Expanded(
          child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 3.0,
          child: CachedNetworkImage(
            imageUrl: controller.photo.value!.urls.regular,
            fit: BoxFit.contain,
            placeholder: (context, url) => const LoadingWidget(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          ),
          ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.photo.value!.description != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        controller.photo.value!.description!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  if (controller.photo.value!.user != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        children: [
                          if (controller.photo.value!.user!.profileImage?.medium != null)
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(
                                controller.photo.value!.user!.profileImage!.medium!,
                              ),
                            ),
                          const SizedBox(width: 8),
                          Text(
                            'Photo by ${controller.photo.value!.user!.name ?? controller.photo.value!.user!.username}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(() => ElevatedButton.icon(
                        icon: const Icon(Icons.wallpaper),
                        label: Text(controller.isSettingWallpaper.value
                            ? 'Setting...'
                            : 'Set Wallpaper'),
                        onPressed: controller.isSettingWallpaper.value
                            ? null
                            : () {
                          // _showWallpaperOptions(context);
                        },
                      )),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        onPressed: () {
                          // Implement share functionality
                          Get.snackbar(
                            'Share',
                            'Sharing functionality to be implemented',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
      );
        },
        ),
    );
  }

  // void _showWallpaperOptions(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: <Widget>[
  //             ListTile(
  //               leading: const Icon(Icons.home),
  //               title: const Text('Home Screen'),
  //               onTap: () {
  //                 Get.back();
  //                 controller.downloadAndSetWallpaper(
  //                   WallpaperManagerFlutter.HOME_SCREEN,
  //                 );
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.lock),
  //               title: const Text('Lock Screen'),
  //               onTap: () {
  //                 Get.back();
  //                 controller.downloadAndSetWallpaper(
  //                   WallpaperManagerFlutter.LOCK_SCREEN,
  //                 );
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(Icons.smartphone),
  //               title: const Text('Both Screens'),
  //               onTap: () {
  //                 Get.back();
  //                 controller.downloadAndSetWallpaper(
  //                   WallpaperManagerFlutter.BOTH_SCREENS,
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}