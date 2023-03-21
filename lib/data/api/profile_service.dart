import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/profile_repo.dart';
import 'package:itb_ganecare/models/profile_v2.dart';

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
        // log('${response.data}', name: 'get-profile');
        return Right(response.data);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, Map<String, dynamic>>> getProfileV2(
      String noreg) async {
    Failed failure;

    try {
      final response = await _dio.getUri(
        Uri.http(kemahasiswaanBaseUrl_, profileUrlV2_, {'no_reg': noreg}),
      );

      if (response.statusCode == 200) {
        log('${response.data}', name: 'get-profile-v2');
        return Right(response.data);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, int>> updateProfileService(
      String noReg, String nickName, String about, String role) async {
    Failed failure;
    FormData formData = FormData.fromMap(
      {
        'no_reg': noReg,
        'nickname': nickName,
        'about': about,
        'role': role,
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

  @override
  Future<Either<Failed, int>> updatePhotoService(
      String noReg, File file, String role) async {
    Failed failure;

    FormData uploadData = FormData.fromMap({
      'no_reg': noReg,
      'file': await MultipartFile.fromFile(file.path, filename: file.path),
      'token': token_,
      'role': role,
    });

    try {
      final response = await Dio()
          .post('https://kemahasiswaan.itb.ac.id/api/person/update_foto',
              data: uploadData,
              options: Options(
                  followRedirects: false,
                  validateStatus: (status) {
                    return status! < 500;
                  }));

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'post-login');
        print("Response 200");
        print(200);
        return const Right(200);
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      print(e);
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
