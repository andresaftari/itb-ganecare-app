import 'dart:developer';

import 'package:itb_ganecare/data_provider/app_data_provider.dart';

class AppDataRepository {
  final AppDataProvider? appDataProvider;

  AppDataRepository({this.appDataProvider});

  Future<bool?> toggleDarkMode() async {
    final isDarkMode = await appDataProvider?.toggleDarkMode();

    try {
      if (isDarkMode != null) {
        return isDarkMode;
      } else {
        return false;
      }
    } catch (exception) {
      _appDataRepositoryErrorHandling(exception);
    }

    return null;
  }

  void _appDataRepositoryErrorHandling(dynamic exception) {
    String message;
    try {
      message = exception.message;
    } catch (_) {
      message = exception.toString();
    }

    log('appDataRepo exception: $message');
    throw exception;
  }
}