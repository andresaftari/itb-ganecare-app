import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/profile_repo.dart';

class ProfileService extends ProfileRepository {
  final Dio _dio;

  ProfileService(this._dio);

  @override
  Future<Either<Failed, Map<String, dynamic>>> getProfile(String nim) async {
    Failed failure;

    try {
      final response = await _dio.getUri(
        Uri.http(kemahasiswaanBaseUrl_, profileUrl_, {'nim': nim}),
      );

      if (response.statusCode == 200) {
        log('${response.data}', name: 'get-profile');
        return Right(response.data);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  Future<Either<Failed, int>> updateProfileService(
      String noReg, String nickName, String about) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {
        'no_reg': noReg,
        'nickname': nickName,
        'about': about,
      },
    );

    try {
      final response = await _dio.postUri(
        Uri.http(kemahasiswaanBaseUrl_, profileUpdateUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'post-login');
        print("Response 200");
        print(200);
        return const Right(200);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
