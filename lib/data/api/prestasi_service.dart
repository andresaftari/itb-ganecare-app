import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/counseling_repo.dart';
import 'package:itb_ganecare/data/repo/prestasi_repo.dart';
import 'package:itb_ganecare/models/counseling.dart';
import 'package:itb_ganecare/models/prestasi.dart';

class PrestasiService extends PrestasiRepo {
  final Dio _dio;

  PrestasiService(this._dio);

  @override
  Future<Either<Failed, GetPrestasi>> getPrestasi() async {
    Failed failure;

    try {
      final response = await _dio.get(
          'https://kemahasiswaan.itb.ac.id/api/prestasi/ganecare_best5penghargaan');

      if (response.statusCode == 200) {
        log('${response.data}', name: 'get-prestasi');
        return Right(GetPrestasi.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, Map<String, dynamic>>> getDetailPrestasi(
      String idPenghargaan) async {
    Failed failure;

    try {
      final response = await _dio.getUri(
        Uri.http(baseUrl_, detailPrestasiUrl_,
            {'id_penghargaan': idPenghargaan}),
      );

      if (response.statusCode == 200) {
        log('${response.data}', name: 'get-detail-prestasi');
        return Right(response.data);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
