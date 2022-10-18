import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AppDataProvider {
  Future<bool?> toggleDarkMode() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    try {
      if (localStorage.containsKey('dark_mode')) {
        if (localStorage.getBool('dark_mode') == null) {
          localStorage.setBool('dark_mode', false);
        } else {
          localStorage.setBool('dark_mode', true);
        }

        return localStorage.getBool('dark_mode');
      } else {
        localStorage.setBool('dark_mode', true);
        return true;
      }
    } on SocketException {
      throw const SocketException('Tidak ada koneksi 😑');
    } catch (exception) {
      _appDataProviderErrorHandling(exception);
    }
    return null;
  }

  void _appDataProviderErrorHandling(dynamic exception) {
    String message;
    try {
      message = exception.message;
    } catch (_) {
      message = exception.toString();
    }

    log('appDataProvider exception: $message');
    throw exception;
  }
}