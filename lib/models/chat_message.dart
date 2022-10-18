import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String messageId;
  final String chatroomId;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateCreated;
  final DateTime? dateUpdated;
  final int status;
  final bool isDeleted;

  const ChatMessage({
    this.messageId = '',
    this.senderId = '',
    this.receiverId = '',
    this.message = '',
    required this.chatroomId,
    required this.dateCreated,
    required this.dateUpdated,
    required this.status,
    this.isDeleted = false,
  });

  factory ChatMessage.fromJson(dynamic jsonData) {
    // print("Deletion status: ${jsonData['deleted']}");
    return ChatMessage(
      chatroomId: jsonData['chatroom_id'].toString(),
      dateCreated: DateTime.parse(jsonData['created_at']),
      dateUpdated: jsonData['updated_at'] != null
          ? DateTime.parse(jsonData['updated_at'])
          : null,
      message: jsonData['message'],
      messageId: jsonData['id'].toString(),
      senderId: jsonData['sender_id'].toString(),
      receiverId: jsonData['receiver_id'].toString(),
      status: jsonData['status'] as int,
      isDeleted: jsonData['deleted'] == 0 ? false : true,
    );
  }

  @override
  List<Object> get props => [];
}
