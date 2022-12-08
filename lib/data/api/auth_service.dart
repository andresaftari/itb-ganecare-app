import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/auth_repo.dart';
import 'package:itb_ganecare/models/auth.dart';
import 'package:itb_ganecare/network/endpoint.dart';

class AuthService extends AuthRepository {
  final Dio _dio;

  AuthService(this._dio);

  @override
  Future<Either<Failed, Login>> postLogin(String username, String password) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {
        'username': username,
        'password': password,
        'token': token_
      },
    );

    try {
      final response = await _dio.postUri(
        Uri.parse(loginUrl_),
        data: formData,
      );

      if (response.statusCode == 200) {
        return Right(loginFromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}