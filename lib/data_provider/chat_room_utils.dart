import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:itb_ganecare/models/chats.dart';

class FirestoreUtils extends ChangeNotifier {
  // StreamSubscription<QuerySnapshot>? _roomSubscription;

  List<Rooms> _chatRoomList = [];
  List<Rooms> get roomList => _chatRoomList;

  List<Chats> _chatList = [];
  List<Chats> get chatList => _chatList;

  Future getLiveChatRoom() async {
    FirebaseFirestore.instance.collection('rooms').snapshots().listen((event) {
      _chatRoomList = [];

      for (final documents in event.docs) {
        _chatRoomList.add(
          Rooms(
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
        );
      }
    });
  }

  Future getLiveChat(String roomId) async {
    FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('chats')
        .snapshots()
        .listen((event) {
      _chatList = [];

      for (final documents in event.docs) {
        _chatList.add(Chats(
          dateTime: documents.data()['dateTime'],
          idReceiver: documents.data()['idReceiver'],
          idRoom: documents.data()['idRoom'],
          idSender: documents.data()['idSender'],
          isRead: documents.data()['isRead'],
          message: documents.data()['message'],
          type: documents.data()['type'],
        ));
      }
    });
  }
}
