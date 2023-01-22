import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/counseling_repo.dart';

class CounselingService extends CounselingRepo {
  final Dio _dio;

  CounselingService(this._dio);

  @override
  Future<Either<Failed, Map<String, dynamic>>> postPeerCouncelee(
    String nim,
    String nama,
  ) async {
    Failed failure;

    FormData formData = FormData.fromMap({
      'nim': nim,
      'name': nama,
    });

    try {
      final response = await _dio.postUri(
        Uri.http(kemahasiswaanBaseUrl_, peerConseleeUrl_),
        options: Options(contentType: 'multipart/form-data'),
        data: formData,
      );

      if (response.statusCode == 200) {
        log('${response.data}', name: 'post-counselee');
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
