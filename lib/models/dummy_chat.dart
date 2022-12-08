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
  String messageType;

  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}
