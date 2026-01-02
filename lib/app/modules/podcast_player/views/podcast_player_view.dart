import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/podcast_player_controller.dart';
import '../../../data/model/episode_model.dart';

class PodcastPlayerView extends GetView<PodcastPlayerController> {
  const PodcastPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final Episode episode = args['episode'];

    // Initialize player with episode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.playEpisode(episode);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Podcast Player'),
        surfaceTintColor: Colors.transparent,
      ),

      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    Obx(() {
                      final isPlaying = controller.isPlaying.value;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isPlaying ? 280.w : 270.w,
                        height: isPlaying ? 280.w : 270.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.primary
                                  .withOpacity(isPlaying ? 0.2 : 0.1),
                              blurRadius: isPlaying ? 40 : 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.r),
                          child: CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/id/237/400/400',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Theme.of(context).colorScheme.primary,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),

                    SizedBox(height: 40.h),

                    Text(
                      'The Blockchain Experience',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      'Media3 Labs LLC',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    Obx(() {
                      final currentEp = controller.currentEpisode.value;
                      return Text(
                        currentEp?.subtitle ?? episode.subtitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      );
                    }),

                    SizedBox(height: 40.h),

                    Obx(() {
                      return Column(
                        children: [
                          // Slider
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 4.h,
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 8.r,
                              ),
                              overlayShape: RoundSliderOverlayShape(
                                overlayRadius: 16.r,
                              ),
                            ),
                            child: Slider(
                              value: controller.progress.clamp(0.0, 1.0),
                              activeColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              inactiveColor: Colors.grey[700],
                              onChanged: (value) {
                                final position =
                                    controller.totalDuration.value * value;
                                controller.seek(position);
                              },
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.formatDuration(
                                    controller.currentPosition.value,
                                  ),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                ),
                                Obx(() {
                                  return DropdownButton<double>(
                                    value: controller.playbackSpeed.value,
                                    dropdownColor: Theme.of(
                                      context,
                                    ).cardColor,
                                    underline: Container(),
                                    items: [0.5, 0.75, 1.0, 1.25, 1.5, 2.0]
                                        .map((speed) {
                                          return DropdownMenuItem(
                                            value: speed,
                                            child: Text(
                                              '${speed}x',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color:
                                                    controller
                                                            .playbackSpeed
                                                            .value ==
                                                        speed
                                                    ? Theme.of(
                                                        context,
                                                      ).colorScheme.primary
                                                    : Theme.of(context)
                                                          .colorScheme
                                                          .onSurface
                                                          .withOpacity(0.5),
                                              ),
                                            ),
                                          );
                                        })
                                        .toList(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.setSpeed(value);
                                      }
                                    },
                                  );
                                }),
                                Text(
                                  controller.formatDuration(
                                    controller.totalDuration.value,
                                  ),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),

                    SizedBox(height: 30.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(Icons.replay_10, size: 36.sp),
                          onPressed: controller.skipBackward,
                        ),

                        Obx(() {
                          final isLoading = controller.isLoading.value;
                          final isPlaying = controller.isPlaying.value;

                          return GestureDetector(
                            onTap: isLoading
                                ? null
                                : controller.togglePlayPause,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary,
                                    Theme.of(context).colorScheme.secondary,
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.4),
                                    blurRadius: isPlaying ? 25 : 15,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: isLoading
                                  ? Center(
                                      child: SizedBox(
                                        width: 30.w,
                                        height: 30.w,
                                        child:
                                            const CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3,
                                            ),
                                      ),
                                    )
                                  : AnimatedSwitcher(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      transitionBuilder: (child, animation) {
                                        return ScaleTransition(
                                          scale: animation,
                                          child: child,
                                        );
                                      },
                                      child: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        key: ValueKey<bool>(isPlaying),
                                        color: Colors.white,
                                        size: 40.sp,
                                      ),
                                    ),
                            ),
                          );
                        }),

                        IconButton(
                          icon: Icon(Icons.forward_10, size: 36.sp),
                          onPressed: controller.skipForward,
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
