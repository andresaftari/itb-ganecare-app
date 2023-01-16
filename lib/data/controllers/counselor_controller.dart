import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/counselor_service.dart';

class CouncelorController extends GetxController {
  final CouncelorService councelorService = CouncelorService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future postPeerCouncelor(
    String year,
    String major,
    String gender,
  ) async {
    var res;

    final result = await councelorService.postPeerCouncelor(year, major, gender);

    result.fold((l) {
      log('failed to get quickhelp ${l.message}', name: 'get-quickhelp');
      hasError(true);
      errorValue('failed to get quickhelp');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}