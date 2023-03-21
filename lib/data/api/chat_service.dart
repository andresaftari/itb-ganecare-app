import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:itb_ganecare/data/endpoint.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/data/repo/chat_repo.dart';
import 'package:itb_ganecare/models/chats.dart';

class ChatService extends ChatRepo {
  final Dio _dio;

  ChatService(this._dio);

  @override
  Future<Either<Failed, EndChat>> postEndChat(
    String uuid,
    int conselorId,
    int conseleeId,
    DateTime createdAt,
    String roomId,
    List<Chats> list,
  ) async {
    Failed failure;
    
    try {
      var datalist = [];
      if (datalist.isNotEmpty) datalist.clear();

      for (Chats element in list) {
        var dataset = {
          'created_at': element.dateTime,
          'sender_id': element.idSender,
          'receiver_id': element.idReceiver,
          'chatroom_uuid': element.idRoom,
          'message': element.message,
          'status': 1,
        };

        datalist.add(dataset);
      }

      var data = {
        'uuid': uuid,
        'conselor_id': conselorId,
        'conselee_id': conseleeId,
        'created_at': createdAt,
        'chats': List<Map<String, Chats>>.from(datalist)
      };

      final response = await _dio.postUri(
          Uri.https(baseUrl_, beasiswaTersediaUrl_),
          data: jsonEncode(data),
        );

      if (response.statusCode == 200) {
        return Right(EndChat.fromJson(response.data));
      } else {
        throw '${response.statusCode}: ${response.statusMessage}';
      }
    } on DioError catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
