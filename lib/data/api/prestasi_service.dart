import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/counseling_repo.dart';
import 'package:itb_ganecare/data/repo/prestasi_repo.dart';
import 'package:itb_ganecare/models/counseling.dart';

class PrestasiService extends PrestasiRepo {
  final Dio _dio;

  PrestasiService(this._dio);
}
