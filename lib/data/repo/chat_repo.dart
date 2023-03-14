abstract class ChatRepo {
  Future postEndChat(
    String uuid,
    String conselorId,
    String conseleeId,
    DateTime createdAt,
    int senderId,
    String roomId,
    String message,
    int status,
  );
}
