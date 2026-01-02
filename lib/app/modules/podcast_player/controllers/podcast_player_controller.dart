import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/model/episode_model.dart';

class PodcastPlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  var currentEpisode = Rxn<Episode>();
  var playbackSpeed = 1.0.obs;
  var isPlaying = false.obs;
  var isLoading = false.obs;
  var currentPosition = Duration.zero.obs;
  var totalDuration = Duration.zero.obs;
  var bufferedPosition = Duration.zero.obs;

  Stream<Duration?> get positionStream => player.positionStream;

  Stream<Duration?> get durationStream => player.durationStream;

  Stream<Duration?> get bufferedPositionStream => player.bufferedPositionStream;

  @override
  void onInit() {
    super.onInit();
    _setupPlayerListeners();
  }

  void _setupPlayerListeners() {
    player.positionStream.listen((position) {
      currentPosition.value = position;
    });

    player.durationStream.listen((duration) {
      if (duration != null) {
        totalDuration.value = duration;
      }
    });

    player.bufferedPositionStream.listen((position) {
      bufferedPosition.value = position;
    });

    player.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      isLoading.value =
          state.processingState == ProcessingState.loading ||
          state.processingState == ProcessingState.buffering;
    });
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  Future<void> closePlayer() async {
    await player.stop();
    currentEpisode.value = null;
    isPlaying.value = false;
  }

  Future<void> playEpisode(Episode episode) async {
    try {
      if (currentEpisode.value == episode) {
        if (!isPlaying.value) {
          await player.play();
        }
        return;
      }

      if (currentEpisode.value != episode) {
        currentEpisode.value = episode;
        isLoading.value = true;

        playbackSpeed.value = 1.0;
        await player.setSpeed(1.0);

        await player.setAsset(episode.audioUrl);
      }

      await player.play();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to play episode: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading.value = false;
    }
  }

  Future<void> togglePlayPause() async {
    if (isPlaying.value) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Future<void> setSpeed(double speed) async {
    playbackSpeed.value = speed;
    await player.setSpeed(speed);
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Future<void> skipForward() async {
    final position = currentPosition.value + const Duration(seconds: 10);
    final duration = totalDuration.value;
    await seek(position > duration ? duration : position);
  }

  Future<void> skipBackward() async {
    final position = currentPosition.value - const Duration(seconds: 10);
    await seek(position < Duration.zero ? Duration.zero : position);
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  double get progress {
    if (totalDuration.value.inMilliseconds == 0) return 0.0;
    return currentPosition.value.inMilliseconds /
        totalDuration.value.inMilliseconds;
  }

  double get bufferedProgress {
    if (totalDuration.value.inMilliseconds == 0) return 0.0;
    return bufferedPosition.value.inMilliseconds /
        totalDuration.value.inMilliseconds;
  }
}
