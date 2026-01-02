import 'package:get/get.dart';

import '../controllers/podcast_player_controller.dart';

class PodcastPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PodcastPlayerController>(
      () => PodcastPlayerController(),
    );
  }
}
