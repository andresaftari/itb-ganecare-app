import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/prestasi_service.dart';

class PrestasiController {
  final PrestasiService _prestasiService = PrestasiService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getPretasi() async {
    var res;

    final result = await _prestasiService.getPrestasi();
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

  Future getDetailPrestasi(String idPenghargaan) async {
    var res;

    final result = await _prestasiService.getDetailPrestasi(idPenghargaan);

    result.fold((l) {
      log('failed to get profile ${l.message}',
          name: 'get-detail-penghargaan-controller');
      hasError(true);
      errorValue('failed to get profile');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
