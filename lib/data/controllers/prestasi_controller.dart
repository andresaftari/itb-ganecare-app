import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/prestasi_service.dart';

class PrestasiController {
  final PrestasiService _PrestasiService = PrestasiService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  

 
}
