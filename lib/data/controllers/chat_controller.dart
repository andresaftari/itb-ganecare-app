import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/api/chat_service.dart';
import 'package:itb_ganecare/models/chats.dart';

class ChatController {
  final ChatService _chatService = ChatService(Dio());

  RxBool hasError = false.obs;
  RxString errorValue = ''.obs;

  Future postEndChat(
    String uuid,
    int conselorId,
    int conseleeId,
    DateTime createdAt,
    String roomId,
    List<Chats> list,
  ) async {
    var res;

    final result = await _chatService.postEndChat(
      uuid, 
      conselorId, 
      conseleeId, 
      createdAt, 
      roomId,
      list
    );

    result.fold((l) {
      log('failed to end chat ${l.message}', name: 'post-end-chat');
      hasError(true);
      errorValue('failed to end chat');
    }, (r) {
      res = r;
      return r;
    });

    return res;
  }
}