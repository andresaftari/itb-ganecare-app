import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/home_service.dart';

class HomeController {
  final HomeService _homeService = HomeService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future getQuickHelp(String page) async {
    var res;

    final result = await _homeService.getQuickHelp(page);

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

  Future postQuickHelp(String idUser) async {
    var res;

    final result = await _homeService.postQuickHelp(idUser);

    result.fold((l) {
      log('failed to send quickhelp ${l.message}', name: 'post-quickhelp');
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
      log('failed to get userid ${l.message}', name: 'post-getuserid');
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
      log('failed to get beasiswa ${l.message}', name: 'post-listbeasiswa');
      hasError(true);
      errorValue('failed to get beasiswa');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
