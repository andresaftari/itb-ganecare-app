import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/home_repo.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/models/beasiswa.dart';
import 'package:itb_ganecare/models/quick_help.dart';

class HomeService extends HomeRepo {
  final Dio _dio;

  HomeService(this._dio);

  @override
  Future<Either<Failed, MetaHelp>> getQuickHelp() async {
    Failed failure;

    try {
      final response = await _dio.getUri(
        Uri.http(kemahasiswaanBaseUrl_, getQuickHelpUrl_, {
          'limit': '5',
          'page': '1',
        }),
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'get-quickhelp');
        return Right(MetaHelp.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, QuickHelp>> postQuickHelp(
    String idUser,
  ) async {
    Failed failure;

    FormData formData = FormData.fromMap({'idUser': idUser});

    try {
      final response = await _dio.postUri(
        Uri.http(kemahasiswaanBaseUrl_, quickHelpUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'post-quickhelp');
        return Right(QuickHelp.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, Map<String, dynamic>>> postUserID(String nim) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {
        'token': token_,
        'nim': nim,
      },
    );

    try {
      final response = await _dio.postUri(
        Uri.https(baseUrl_, userIdUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        // log('${(response.data)}', name: 'post-userid');
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
  Future<Either<Failed, Beasiswa>> postBeasiswaList(
    String userid,
  ) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {'token': token_, 'user_id': userid},
    );

    try {
      final response = await _dio.postUri(
        Uri.https(baseUrl_, beasiswaTersediaUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        return Right(Beasiswa.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
