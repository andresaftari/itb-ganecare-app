import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itb_ganecare/data/failed.dart';
import 'package:itb_ganecare/models/chats.dart';

class FirestoreUtils extends ChangeNotifier {
  final RxList<Rooms> _chatRoomList = <Rooms>[].obs;

  List<Rooms> get roomList => _chatRoomList;
  List<Chats> chatList = [];

  Stream<List<Rooms>> getLiveChatRoom() async* {
    yield* FirebaseFirestore.instance.collection('rooms').snapshots().map(
      (snapshot) {
        List<Rooms> data = snapshot.docs
            .map(
              (documents) => Rooms(
                id: documents.id.toString(),
                createdAtRoom: documents.data()['createdAtRoom'],
                genderConselee: documents.data()['genderConselee'],
                genderConselor: documents.data()['genderConselor'],
                generationConselee: documents.data()['generationConselee'],
                generationConselor: documents.data()['generationConselor'],
                idConselee: documents.data()['idConselee'],
                idConselor: documents.data()['idConselor'],
                inRoomConselee: documents.data()['inRoomConselee'],
                inRoomConselor: documents.data()['inRoomConselor'],
                lastMessageConselee: documents.data()['lastMessageConselee'],
                lastMessageConselor: documents.data()['lastMessageConselor'],
                majorConselee: documents.data()['majorConselee'],
                majorConselor: documents.data()['majorConselor'],
                nameConselee: documents.data()['nameConselee'],
                nameConselor: documents.data()['nameConselor'],
                photoConselee: documents.data()['photoConselee'],
                photoConselor: documents.data()['photoConselor'],
                roomStatus: documents.data()['roomStatus'],
              ),
            )
            .toList();
        return data;
      },
    );
  }

  Stream<List<Chats>> getLiveChat(String roomId) async* {
    yield* FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('chats')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (documents) => Chats(
                dateTime: documents.data()['dateTime'],
                idReceiver: documents.data()['idReceiver'],
                idRoom: documents.data()['idRoom'],
                idSender: documents.data()['idSender'],
                isRead: documents.data()['isRead'],
                message: documents.data()['message'],
                type: documents.data()['type'],
              ),
            )
            .toList());
  }

  Future postLiveChat(
    String roomId,
    DateTime dateTime,
    int idReceiver,
    int idSender,
    String message,
    String type,
  ) async {
    Failed failure;
    // DateTime currentDate = DateTime.now();

    // String today = DateFormat.yMMMMd().format(currentDate);
    // String time = DateFormat.jms().format(currentDate);
    // String date = '$today at $time UTC+7';

    try {
      Chats chat = Chats(
        dateTime: Timestamp.fromDate(dateTime),
        idReceiver: idReceiver,
        idRoom: roomId,
        idSender: idSender,
        isRead: false,
        message: message,
        type: type,
      );

      log('chat $chat', name: 'data');

      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('chats')
          .add({
        'dateTime': Timestamp.fromDate(dateTime),
        'idRoom': roomId,
        'idReceiver': idReceiver,
        'idSender': idSender,
        'isRead': false,
        'message': message,
        'type': type,
      });
    } catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  Future createNewRoom(
    String genderConselee,
    String genderConselor,
    String generationConselee,
    String generationConselor,
    String idConselee,
    String idConselor,
    String majorConselee,
    String majorConselor,
    String nameConselee,
    String nameConselor,
  ) async {
    Failed failure;

    try {
      FirebaseFirestore.instance.collection('rooms').add({
        'createdAtRoom': Timestamp.fromDate(DateTime.now()),
        'genderConselee': genderConselee,
        'genderConselor': genderConselor,
        'generationConselee': generationConselee,
        'generationConselor': generationConselor,
        'idConselee': idConselee,
        'idConselor': idConselee,
        'inRoomConselee': false,
        'inRoomConselor': false,
        'lastMessageConselee': '',
        'lastMessageConselor': '',
        'majorConselee': majorConselee,
        'majorConselor': majorConselor,
        'nameConselee': nameConselee,
        'nameConselor': nameConselor,
        'photoConselee':
            'https://kerma.widyatama.ac.id/wp-content/uploads/2021/05/blank-profile-picture-973460_1280.png',
        'photoConselor':
            'https://kerma.widyatama.ac.id/wp-content/uploads/2021/05/blank-profile-picture-973460_1280.png',
        'roomStatus': 'request',
      });
    } catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  Future updateInRoom({
    required String roomId,
    bool? isCounselorInRoom,
    bool? isCounseleeInRoom,
  }) async {
    Failed failure;

    try {
      if (isCounseleeInRoom != null) {
        FirebaseFirestore.instance.collection('rooms').doc(roomId).update(
          {
            'inRoomConselee': isCounseleeInRoom,
          },
        );
      }

      if (isCounselorInRoom != null) {
        FirebaseFirestore.instance.collection('rooms').doc(roomId).update(
          {
            'inRoomConselor': isCounselorInRoom,
          },
        );
      }
    } catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }

  Future updateIsRead(
    String roomId,
    String chatId,
  ) async {
    Failed failure;

    try {
      FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomId)
          .collection('chats')
          .doc(chatId)
          .update(
        {
          'isRead': true,
        },
      );
    } catch (e) {
      failure = Failed(e.toString());
      return Left(failure);
    }
  }
}
