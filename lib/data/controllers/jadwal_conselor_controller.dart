import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/beasiswa_service.dart';
import 'package:itb_ganecare/data/api/jadwal_conselor_service.dart';
import 'package:itb_ganecare/data/api/jadwal_service.dart';

class JadwalConselorController {
  final JadwalConselorService _jadwalConselorService =
      JadwalConselorService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getJadwal() async {
    var res;

    final result = await _jadwalConselorService.getJadwalConselorService();
    result.fold((l) {
      // log('failed to get quickhelp ${l.message}',
      //     name: 'get-jadwal-controller-conselor');
      // print('masuk==== jadwal conselor');
      hasError(true);
      errorValue('failed to get quickhelp');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
