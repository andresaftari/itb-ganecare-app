import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/moodtracker_repo.dart';
import 'package:itb_ganecare/models/moodtracker_model.dart';

import '../endpoint.dart';

class MoodTrackerService extends MoodTrackerRepo {
  final Dio _dio;

  MoodTrackerService(this._dio);

  @override
  Future<Either<Failed, GetMoodTracker>> getMoodTrackerService() async {
    Failed failure;
    try {
      final response = await _dio.post(
        'http://167.205.57.127:8080/api/v1/status/get_status',
        queryParameters: {
          'no_reg': '22102224',
        },
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'get-mood-tracker');
        return Right(GetMoodTracker.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, int>> postMoodTrackerService(
    String text,
    String mood,
    String emotion,
  ) async {
    Failed failure;
    FormData formData = FormData.fromMap(
      {
        'text': text,
        'mood': mood,
        'emotion': emotion,
        'no_reg': '22102224',
      },
    );

    try {
      final response = await _dio.postUri(
        Uri.http(kemahasiswaanBaseUrl_, postMoodTrakcerUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'post-login');
        // print("Response 200");
        // print(200);
        return const Right(200);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  // @override
  // Future<Either<Failed, GetPrestasi>> getPrestasi() async {
  //   Failed failure;

  //   try {
  //     final response = await _dio.get(
  //         'https://kemahasiswaan.itb.ac.id/api/prestasi/ganecare_best5penghargaan');

  //     if (response.statusCode == 200) {
  //       // log('${response.data}', name: 'get-prestasi');
  //       return Right(GetPrestasi.fromJson(response.data));
  //     } else {
  //       throw '${response.statusCode}: ${response.statusMessage}';
  //     }
  //   } on DioError catch (e) {
  //     failure = Failed(e.toString());
  //     return Left(failure);
  //   }
  // }

  // @override
  // Future<Either<Failed, Map<String, dynamic>>> getDetailPrestasi(
  //     String idPenghargaan) async {
  //   Failed failure;

  //   try {
  //     final response = await _dio.getUri(
  //       Uri.http(baseUrl_, detailPrestasiUrl_,
  //           {'id_penghargaan': idPenghargaan}),
  //     );

  //     if (response.statusCode == 200) {
  //       // log('${response.data}', name: 'get-detail-prestasi');
  //       return Right(response.data);
  //     } else {
  //       throw '${response.statusCode}: ${response.statusMessage}';
  //     }
  //   } on DioError catch (e) {
  //     failure = Failed(e.toString());
  //     return Left(failure);
  //   }
  // }
}
