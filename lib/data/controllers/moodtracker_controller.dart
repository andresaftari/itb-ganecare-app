import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/moodtracker_service.dart';

class MoodTrackerController {
  final MoodTrackerService _moodTrackerService = MoodTrackerService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getMoodTracker() async {
    var res;

    final result = await _moodTrackerService.getMoodTrackerService();
    result.fold((l) {
      log('failed to get mood tracker ${l.message}', name: 'get-quickhelp');
      hasError(true);
      errorValue('failed to get mood tracker');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }

  Future postMoodTracker(String text, String mood, String emotion) async {
    var res;

    final result = await _moodTrackerService.postMoodTrackerService(
      text,
      mood,
      emotion,
    );

    result.fold((l) {
      log('failed to get profile ${l.message}', name: 'get-profile');
      hasError(true);
      errorValue('failed to get profile');
    }, (r) {
      res = r;
      print(r);
      return r;
    });

    return res;
  }
}
