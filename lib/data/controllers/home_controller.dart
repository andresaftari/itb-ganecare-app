import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/home_service.dart';

class HomeController {
  final HomeService _homeService = HomeService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future postQuickHelp(String idUser) async {
    var res;

    final result = await _homeService.postQuickHelp(idUser);

    result.fold((l) {
      log('failed to send quickhelp', name: 'send quickhelp');
      hasError(true);
      errorValue('failed to send quickhelp');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
