import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/profile_service.dart';
import 'package:itb_ganecare/models/profile_v2.dart';

class ProfileController {
  final ProfileService _profileService = ProfileService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getProfile(String nim) async {
    var res;

    final result = await _profileService.getProfile(nim);

    result.fold((l) {
      log('failed to get profile ${l.message}', name: 'get-profile');
      hasError(true);
      errorValue('failed to get profile');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
  
  Future getProfileV2(String noReg) async {
    var res;

    final result = await _profileService.getProfileV2(noReg);

    result.fold((l) {
      log('failed to get profile ${l.message}', name: 'get-profile');
      hasError(true);
      errorValue('failed to get profile');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }

  Future updateProfile(String noReg, String nickName, String about,String role) async {
    var res;

    final result =
        await _profileService.updateProfileService(noReg, nickName, about,role);

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
  Future updatePhoto(String noReg, File file, String role) async {
    var res;

    final result =
        await _profileService.updatePhotoService(noReg, file, role);

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
