import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future postLogin(
    String username,
    String password,
    String deviceId,
  ) async {
    var res;

    final result = await _authService.postLogin(username, password, deviceId);

    result.fold((l) {
      log('failed to login ${l.message}', name: 'login status');
      hasError(true);
      errorValue('failed to login');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}
