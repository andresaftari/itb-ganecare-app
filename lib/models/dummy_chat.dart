class ChatUsers {
  String name;
  String messageText;
  String time;

  ChatUsers({
    required this.name,
    required this.messageText,
    required this.time,
  });
}

class ChatMessage {
  String messageContent;
  int senderId;
  int receiverId;

  ChatMessage({
    required this.messageContent,
    required this.senderId,
    required this.receiverId,
  });
}
