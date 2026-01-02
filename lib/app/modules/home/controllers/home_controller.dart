import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/model/podcast_model.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  var podcast = Rxn<Podcast>();
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPodcastData();
  }

  Future<void> loadPodcastData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final String jsonString = await rootBundle.loadString('assets/podcast_data.json',);

      final Map<String, dynamic> jsonData = json.decode(jsonString);

      podcast.value = Podcast.fromJson(jsonData);

    } catch (e) {
      errorMessage.value = 'Failed to load podcast data: $e';
      podcast.value = null;

      Get.snackbar(
        'Error',
        'Failed to load podcast data',
        snackPosition: SnackPosition.BOTTOM,
      );
    }finally{
      isLoading.value = false;
    }
  }

  void retryLoading() {
    loadPodcastData();
  }
}
