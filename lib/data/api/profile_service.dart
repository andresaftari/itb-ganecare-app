import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/profile_repo.dart';
import 'package:itb_ganecare/data/endpoint.dart';

class ProfileService extends ProfileRepository {
  final Dio _dio;

  ProfileService(this._dio);

  @override
  Future<Either<Failed, Map<String, dynamic>>> getProfile(String nim) async {
    Failed failure;

    try {
      final response = await _dio.getUri(Uri.parse('$profileUrl_?nim=$nim'));

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
}
