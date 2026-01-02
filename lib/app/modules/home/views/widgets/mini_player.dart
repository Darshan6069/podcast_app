import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:podcast/app/modules/podcast_player/controllers/podcast_player_controller.dart';
import 'package:podcast/app/modules/podcast_player/views/podcast_player_view.dart';

class MiniPlayer extends GetView<PodcastPlayerController> {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final episode = controller.currentEpisode.value;
      if (episode == null) return const SizedBox.shrink();

      return GestureDetector(
        onTap: () {
          Get.to(
            () => const PodcastPlayerView(),
            arguments: {'episode': episode},
            transition: Transition.downToUp,
          );
        },
        child: Container(
          height: 70.h,
          margin: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Album Art
              SizedBox(width: 8.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl:
                      episode
                          .audioUrl
                          .isNotEmpty // check if valid or just use dummy
                      ? 'https://picsum.photos/id/237/200/200'
                      : 'https://picsum.photos/200',
                  width: 54.w,
                  height: 54.w,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.music_note),
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Title & Subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      episode.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      episode.subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Controls
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Play/Pause
                  IconButton(
                    icon: Obx(
                      () => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          controller.isPlaying.value
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          key: ValueKey<bool>(controller.isPlaying.value),
                          size: 36.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    onPressed: controller.togglePlayPause,
                  ),

                  // Close
                  IconButton(
                    icon: Icon(Icons.close, size: 24.sp, color: Colors.grey),
                    onPressed: controller.closePlayer,
                  ),
                ],
              ),
              SizedBox(width: 4.w),
            ],
          ),
        ),
      );
    });
  }
}
