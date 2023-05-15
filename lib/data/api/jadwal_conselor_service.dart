import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/jadwal_conselor_repo.dart';
import 'package:itb_ganecare/data/repo/jadwal_repo.dart';
import 'package:itb_ganecare/data/repo/prestasi_repo.dart';
import 'package:itb_ganecare/models/jadwal_model.dart';
import 'package:itb_ganecare/models/jadwal_model_concelor.dart';
import 'package:itb_ganecare/models/prestasi_model.dart';

class JadwalConselorService extends JadwalConcelorRepo {
  final Dio _dio;

  JadwalConselorService(this._dio);

  @override
  Future<Either<Failed, GetJadwalConcelor>> getJadwalConselorService() async {
    Failed failure;

    try {
      final response = await _dio.post(
        'http://167.205.57.127:8080/api/v1/user/getjadwal',
        // queryParameters: {
        //   'no_reg': '22102224',
        // },
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'get-jadwal-conselor');
        return Right(GetJadwalConcelor.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
