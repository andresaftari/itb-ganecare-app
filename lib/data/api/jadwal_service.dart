import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/jadwal_repo.dart';
import 'package:itb_ganecare/data/repo/prestasi_repo.dart';
import 'package:itb_ganecare/models/jadwal_model.dart';
import 'package:itb_ganecare/models/prestasi_model.dart';

class JadwalService extends JadwalRepo {
  final Dio _dio;

  JadwalService(this._dio);

  @override
  Future<Either<Failed, dynamic>> getJadwalService() async {
    Failed failure;

    try {
      final response = await _dio.get(
        'https://kemahasiswaan.itb.ac.id/api/konseling/jadwal',
        queryParameters: {
          'token': 'lh7jNnh0AE1XPlZ4TLjkPmZWgc7bSvoWIVUiPZO1',
          'tgl_awal': '2020-04-01',
          'tgl_akhir': '2020-12-31',
          'is_booked': '0',
        },
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'get-jadwal');
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
