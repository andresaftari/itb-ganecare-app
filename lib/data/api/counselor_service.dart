import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/councelor_repo.dart';
import 'package:itb_ganecare/models/counceling.dart';

class CouncelorService extends CouncelorRepo {
  final Dio _dio;

  CouncelorService(this._dio);

  @override
  Future<Either<Failed, PeerCouncelor?>> postPeerCouncelor(
    String year, 
    String major, 
    String gender,
  ) async {
    Failed failure;

    FormData formData = FormData.fromMap(
      {
        'jurusan': major,
        'angkatan': year,
        'gender': gender,
      },
    );    

    try {
      final response = await _dio.postUri(
        Uri.http(kemahasiswaanBaseUrl_, peerConselorUrl_),
        data: formData,
      ); 

      if (response.statusCode == 200) {
        log('${response.data}', name: 'post-peer');
        return Right(peerCouncelorFromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}