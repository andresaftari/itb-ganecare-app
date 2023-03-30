import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/beasiswa_repo.dart';
import 'package:itb_ganecare/models/beasiswaku_model.dart';

class BeasiswaService extends BeasiswaRepo {
  final Dio _dio;

  BeasiswaService(this._dio);

  @override
  Future<Either<Failed, Map<String, dynamic>>> getBeasiswaService() async {
    Failed failure;

    try {
      final response = await _dio.get(
        'https://kemahasiswaan.itb.ac.id/api/beasiswa/beasiswaku',
        queryParameters: {
          'no_reg': '17102209',
          'token': 'lh7jNnh0AE1XPlZ4TLjkPmZWgc7bSvoWIVUiPZO1',
        },
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'get-beasiswa');
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
