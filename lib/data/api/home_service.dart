import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/home_repo.dart';
import 'package:itb_ganecare/models/auth.dart';
import 'package:itb_ganecare/models/beasiswa.dart';
import 'package:itb_ganecare/models/quick_help.dart';
import 'package:itb_ganecare/network/endpoint.dart';

class HomeService extends HomeRepo {
  final Dio _dio;

  HomeService(this._dio);

  @override
  Future<Either<Failed, QuickHelp>> postQuickHelp(String idUser) async {
    Failed failure;

    try {
      final response = await _dio.postUri(
        Uri.parse(quickHelpUrl_),
        data: {
          'idUser': idUser,
        },
      );

      if (response.statusCode == 200) {
        return Right(quickHelpFromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, ProfileId>> postUserID(String nim) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {'token': token_, 'nim': nim},
    );

    try {
      final response = await _dio.postUri(
        Uri.parse(userIdUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        return Right(profileIdFromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  @override
  Future<Either<Failed, Beasiswa>> postBeasiswaList(String userid) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {'token': token_, 'user_id': userid},
    );

    try {
      final response = await _dio.postUri(
        Uri.parse(beasiswaTersediaUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        return Right(beasiswaFromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
