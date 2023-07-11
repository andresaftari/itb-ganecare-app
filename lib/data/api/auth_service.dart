import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/auth_repo.dart';
import 'package:itb_ganecare/models/auth.dart';

class AuthService extends AuthRepository {
  // {
  //   "client_id" : "91c3fb03-924e-4446-ad6f-06ab9f1ab372",
  //   "authorization_user_agent" : "DEFAULT",
  //   "redirect_uri" : "msauth://com.GaneCare.itb_ganecare/CBdt1odkmieyoqRQEYgAIwitlqQ%3D",
  //   "authorities" : [
  //     {
  //       "type": "AAD",
  //       "audience": {
  //         "type": "AzureADMyOrg",
  //         "tenant_id": "db6e1183-4c65-405c-82ce-7cd53fa6e9dc"
  //       }
  //     }
  //   ]
  // }

  final Dio _dio;
  AuthService(this._dio);

  @override
  Future<Either<Failed, Login>> postLogin(
    String username,
    String password,
    String deviceId,
  ) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {
        'username': username,
        'password': password,
        'device_id': deviceId,
        'token': token_,
      },
    );

    try {
      final response = await _dio
          .postUri(
            Uri.http(kemahasiswaanBaseUrl_, loginUrl_),
            data: formData,
          )
          .timeout(const Duration(minutes: 1));

      if (response.statusCode == 200) {
        // log('${response.data}', name: 'post-login');

        if (response.data.contains('user_mahasiswa')) {
          return Right(loginCounselorFromJson(response.data));
        } else {
          return Right(loginCounseleeFromJson(response.data));
        }
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
