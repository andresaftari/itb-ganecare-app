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
  
  Future postGetUserid(String nim) async {
    var res;
    
    final result = await _homeService.postUserID(nim);

    result.fold((l) {
      log('failed to get userid', name: 'post-getuserid');
      hasError(true);
      errorValue('failed to get userid');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }

  Future postBeasiswa(String userid) async {
    var res;

    final result = await _homeService.postBeasiswaList(userid);

    result.fold((l) {
      log('failed to get beasiswa', name: 'post-listbeasiswa');
      hasError(true);
      errorValue('failed to get beasiswa');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
