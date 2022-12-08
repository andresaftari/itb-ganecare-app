import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future postLogin(String username, String password) async {
    var res;

    final result = await _authService.postLogin(username, password);

    result.fold((l) {
      log('failed to login', name: 'login status');
      hasError(true);
      errorValue('failed to login');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}