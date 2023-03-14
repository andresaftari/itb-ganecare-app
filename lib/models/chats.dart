import 'package:cloud_firestore/cloud_firestore.dart';

class Rooms {
  String id;
  Timestamp createdAtRoom;
  String genderConselee;
  String genderConselor;
  String generationConselee;
  String generationConselor;
  int idConselee;
  int idConselor;
  bool inRoomConselee;
  bool inRoomConselor;
  String lastMessageConselee;
  String lastMessageConselor;
  String majorConselee;
  String majorConselor;
  String nameConselee;
  String nameConselor;
  String photoConselee;
  String photoConselor;
  String roomStatus;

  Rooms({
    required this.id,
    required this.createdAtRoom,
    required this.genderConselee,
    required this.genderConselor,
    required this.generationConselee,
    required this.generationConselor,
    required this.idConselee,
    required this.idConselor,
    required this.inRoomConselee,
    required this.inRoomConselor,
    required this.lastMessageConselee,
    required this.lastMessageConselor,
    required this.majorConselee,
    required this.majorConselor,
    required this.nameConselee,
    required this.nameConselor,
    required this.photoConselee,
    required this.photoConselor,
    required this.roomStatus,
  });

  @override
  String toString() {
    return '''
    _id: $id
    _createdAtRoom : $createdAtRoom
    _genderConselee : $genderConselee
    _genderConselor : $genderConselor
    _generationConselee : $generationConselee
    _generationConselor : $generationConselor
    _idConselee : $idConselee
    _idConselor : $idConselor
    _inRoomConselee : $inRoomConselee
    _inRoomConselor : $inRoomConselor
    _lastMessageConselee : $lastMessageConselee
    _lastMessageConselor : $lastMessageConselor
    _majorConselee : $majorConselee
    _majorConselor : $majorConselor
    _nameConselee : $nameConselee
    _nameConselor : $nameConselor
    _photoConselee : $photoConselee
    _photoConselor : $photoConselor
    _roomStatus : $roomStatus
    ''';
  }
}

class Chats {
  Timestamp dateTime;
  int idReceiver;
  String idRoom;
  int idSender;
  bool isRead;
  String message;
  String type;

  Chats({
    required this.dateTime,
    required this.idReceiver,
    required this.idRoom,
    required this.idSender,
    required this.isRead,
    required this.message,
    required this.type,
  });

  @override
  String toString() {
    return '''
    _dateTime : ${Timestamp(dateTime.seconds, dateTime.nanoseconds).toDate()}
    _idReceiver : $idReceiver
    _idRoom : $idRoom
    _idSender : $idSender
    _isRead : $isRead
    _message : $message
    _type : $type
    ''';
  }
}

class EndChat {
  EndChat({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory EndChat.fromJson(Map<String, dynamic> json) => EndChat(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
