import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/beasiswa_service.dart';
import 'package:itb_ganecare/models/beasiswaku_model.dart';

class BeasiswaController {
  final BeasiswaService _beasiswaService = BeasiswaService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getBeasiswa() async {
    var res;

    final result = await _beasiswaService.getBeasiswaService();

    result.fold((l) {
      hasError(true);
      errorValue('failed to get beasiswa');
    }, (r) {
      res = r;
      return r;
    });
    return res;
  }
}
