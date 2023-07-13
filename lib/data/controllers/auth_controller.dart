import 'dart:developer';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/auth_service.dart';
import 'package:itb_ganecare/main.dart';

class AuthController {
  static final Config config = Config(
    tenant: 'db6e1183-4c65-405c-82ce-7cd53fa6e9dc',
    clientId: '91c3fb03-924e-4446-ad6f-06ab9f1ab372',
    scope: 'openid profile',
    redirectUri:
    'msauth://com.GaneCare.itb_ganecare/CBdt1odkmieyoqRQEYgAIwitlqQ%3D',
    navigatorKey: navigatorKey,
  );

  final AuthService _authService = AuthService(Dio());
  final AadOAuth oauth = AadOAuth(config);

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future azureLogout() async => await oauth.logout();

  Future azureLogin() async {
    var res;

    final result = await oauth.login();

    result.fold((l) {
      log('failed to auth ${l.message}', name: 'azure auth');
      hasError(true);
      errorValue('failed to login');
    }, (r) {
      log(r.toString(), name: 'azure auth');
      res = r;
      return r;
    });

    return res;
  }

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
