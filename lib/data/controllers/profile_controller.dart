import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/profile_service.dart';

class ProfileController {
  final ProfileService _profileService = ProfileService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getProfile(String nim) async {
    var res;

    final result = await _profileService.getProfile(nim);

    result.fold((l) {
      log('failed to get profile', name: 'get-profile');
      hasError(true);
      errorValue('failed to get profile');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}