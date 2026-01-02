import 'package:get/get.dart';
import '../../podcast_player/controllers/podcast_player_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PodcastPlayerController>(() => PodcastPlayerController());
  }
}
