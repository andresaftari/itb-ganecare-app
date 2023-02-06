import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/counseling_service.dart';

class CounselingController {
  final CounselingService _counselingService = CounselingService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future postPeerCounselee(
    String nim,
    String name,
  ) async {
    var res;

    final result = await _counselingService.postPeerCouncelee(nim, name);

    result.fold((l) {
      log('failed to get peer counselee ${l.message}', name: 'post-counselee');
      hasError(true);
      errorValue('failed to get peer counselee');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }

  Future postPeerCounselor(
    String jurusan,
    String angkatan,
    String gender,
  ) async {
    var res;

    final result = await _counselingService.postPeerCounselor(
      jurusan,
      angkatan,
      gender,
    );

    result.fold((l) {
      log('failed to get peer counselor ${l.message}', name: 'post-counselor');
      hasError(true);
      errorValue('failed to get peer counselor');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
