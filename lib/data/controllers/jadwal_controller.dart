import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/beasiswa_service.dart';
import 'package:itb_ganecare/data/api/jadwal_service.dart';

class JadwalController {
  final JadwalService _jadwalService = JadwalService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getJadwal() async {
    var res;

    final result = await _jadwalService.getJadwalService();
    result.fold((l) {
      // log('failed to get quickhelp ${l.message}', name: 'get-jadwal-controller');
      hasError(true);
      errorValue('failed to get quickhelp');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
